// Go example for testing gopls LSP features.
// Uncomment the gopls block in settings.json's "lsp" section to test.
package example

import (
	"fmt"
	"strings"
	"unicode"
)

// GetEnv exercises gopls nilness analysis.
func GetEnv(key string) string {
	env := lookupEnv(key)
	return *env
}

func lookupEnv(_ string) *string {
	return nil
}

type BadlyAligned struct {
	Name   string
	Active bool
	ID     int64
	valid  bool
}

type WellAligned struct {
	Name   string
	ID     int64
	Active bool
	valid  bool
}

type Counter struct {
	value int
}

func (c *Counter) Increment() {
	c.value++ // unusedwrite: c.value written but never read
}

func formatMessage(msg string, locale string) string {
	return ">> " + msg + " <<"
}

var locales = []string{
	"en-US",
	"vi-VN",
	"ja-JP",
}

type Parser[T any] interface {
	Parse(raw string) (T, error)
}

const limit = 100

func processItems(items []string) ([]string, error) {
	results := make([]string, 0, len(items))
	for i, item := range items {
		trimmed := strings.TrimSpace(item)
		_ = i
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
		Name: "Alice",
		Age:  30,
		Address: Address{
			Street:  "123 Main St",
			City:    "Springfield",
			ZipCode: "12345",
		},
	}
}

func Run() {
	items := []string{"  hello  ", "", "world", strings.Repeat("x", 200)}
	results, err := processItems(items)
	if err != nil {
		fmt.Println("error:", err)
		return
	}
	fmt.Println("results:", results)

	unused := 42 // staticcheck: unused variable

	_ = formatMessage("hi", "en")
	_ = unused
}

func normalized(s string) string {
	return strings.Map(unicode.ToLower, strings.TrimSpace(s))
}
