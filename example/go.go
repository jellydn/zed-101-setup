// Go example for testing gopls LSP features
// Uncomment the gopls block in settings.json's "lsp" section to test.
//
// Features exercised:
//   - gofumpt formatting (trailing commas)
//   - staticcheck diagnostics (unused vars)
//   - gopls analyses (unusedparams, unusedwrite, fieldalignment, nilness)
//   - semanticTokens (syntax highlighting granularity)
//   - inlay hints (assignVariableTypes, compositeLiteralFields,
//     compositeLiteralTypes, constantTypeValues, functionDocParameters,
//     parameterNames, rangeVariableTypes)

package example

import (
	"fmt"
	"strings"
	"unicode"
)

// ── Nilness analysis ───────────────────────────────────────────────────────

// GetEnv dereferences lookupEnv's result without a guard, so gopls nilness
// analysis emits "dereference of nil pointer" — exercising the advertised diagnostic.
func GetEnv(key string) string {
	env := lookupEnv(key)       // gopls nilness: env may be nil
	return *env                 // gopls nilness: dereference of nil pointer
}

func lookupEnv(_ string) *string {
	return nil
}

// ── Fieldalignment analysis ────────────────────────────────────────────────

// BadlyAligned has fields ordered sub-optimally; gopls fieldalignment
// analysis should suggest reordering (bytes first → bools last) to
// reduce struct padding.
type BadlyAligned struct {
	Name   string // 16 bytes
	Active bool   //  1 byte  ← should be grouped with other flags
	ID     int64  //  8 bytes
	valid  bool   //  1 byte
}

// WellAligned shows the recommended layout.
type WellAligned struct {
	Name   string // 16 bytes
	ID     int64  //  8 bytes
	Active bool   //  1 byte
	valid  bool   //  1 byte
}

// ── Unusedwrite analysis ───────────────────────────────────────────────────

type Counter struct {
	value int
}

// Increment writes to the receiver but never reads — unusedwrite triggers.
// The value field is never read from this method.
func (c *Counter) Increment() {
	c.value++ // unusedwrite: c.value written but never read
}

// ── Unusedparams analysis ──────────────────────────────────────────────────

func formatMessage(msg string, locale string) string {
	//                                        ^^^^^^  unusedparams: `locale` unused
	return ">> " + msg + " <<"
}

// ── Gofumpt formatting ─────────────────────────────────────────────────────

// Gofumpt enforces a trailing comma after the last element of a block.
// Without gofumpt this would be valid; with gofumpt it gets reformatted.
var locales = []string{
	"en-US",
	"vi-VN",
	"ja-JP",
}

// ── Semantic tokens ────────────────────────────────────────────────────────

// gopls semanticTokens provides richer highlighting for type parameters,
// modifiers (readonly, static), and doc-comment tokens.
type Parser[T any] interface {
	Parse(raw string) (T, error)
}

// ── Inlay hints ────────────────────────────────────────────────────────────

// assignVariableTypes: the `= ` after `err` should show `error`
// parameterNames: each call shows parameter names
// constantTypeValues: `limit` shows type for the untyped constant
// rangeVariableTypes: the for-range variables show their types
// functionDocParameters: the godoc param names carry through

const limit = 100

func processItems(items []string) ([]string, error) {
	results := make([]string, 0, len(items))
	for i, item := range items {
		//  ^^^^ rangeVariableTypes    ^^^^^^ rangeVariableTypes
		trimmed := strings.TrimSpace(item)
		_ = i // use i to avoid compiler error while keeping rangeVariableTypes target
		// ^assignVariableTypes: string
		if trimmed == "" || len(trimmed) > limit {
			continue
		}
		results = append(results, normalized(trimmed))
	}
	if len(results) == 0 {
		return nil, fmt.Errorf("no valid items after processing")
	}
	return results, nil
}

// ── Composite-literal hints ────────────────────────────────────────────────

// compositeLiteralFields and compositeLiteralTypes show field names and
// type names inside composite literals.
type Address struct {
	Street  string
	City    string
	ZipCode string
}

type Person struct {
	Name    string
	Age     int
	Address Address
}

func newPerson() Person {
	return Person{
		//  ^^^^^^ compositeLiteralTypes
		Name: "Alice", //     ^^^^ compositeLiteralFields
		Age:  30,
		Address: Address{
			Street:  "123 Main St",
			City:    "Springfield",
			ZipCode: "12345",
		},
	}
}

// ── Integration ────────────────────────────────────────────────────────────

func Run() {
	items := []string{"  hello  ", "", "world", strings.Repeat("x", 200)}
	results, err := processItems(items)
	if err != nil {
		fmt.Println("error:", err)
		return
	}
	fmt.Println("results:", results)

	// Unused variable triggers staticcheck
	unused := 42 // staticcheck: unused variable

	_ = formatMessage("hi", "en")
	_ = unused
}

// ── Helper: unused param will trigger unusedparams ─────────────────────────

func normalized(s string) string {
	// Gofumpt: functions with no body should still use proper formatting
	return strings.Map(unicode.ToLower, strings.TrimSpace(s))
}
