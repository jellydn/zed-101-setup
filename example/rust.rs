// Rust example for testing rust-analyzer LSP features
// Uncomment the rust-analyzer block in settings.json's "lsp" section to test.
//
// Features exercised:
//   - inlayHints (bindingMode, chaining, closingBrace, lifetime, type, parameter, reborrow)
//   - checkOnSave with clippy
//   - procMacro support (derive macros)
//   - cargo features

#![allow(dead_code)]

use std::collections::HashMap;

// ── Type inlay hints ───────────────────────────────────────────────────────

/// Inlay hints should show `-> Result<(), String>` on the fn line
fn parse_input(raw: &str) -> Result<(), String> {
    if raw.is_empty() {
        return Err("empty input".into());
    }
    Ok(())
}

// ── Binding-mode & parameter inlay hints ──────────────────────────────────

/// Parameter names appear on each call; binding mode hints on `ref` / `mut`
fn process_pair((left, right): (u32, &str)) -> String {
    format!("{left}:{right}")
}

// ── Lifetime-elision hints ─────────────────────────────────────────────────

/// lifetimeElisionHints should show the elided lifetimes
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() { x } else { y }
}

struct RefKeeper<'a> {
    value: &'a str,
}

// ── Closure chaining & reborrow hints ─────────────────────────────────────

/// chainingHints show .iter().filter().map() pipeline types;
/// reborrowHints show implicit reborrows when passing &mut
fn score_items(data: &[u32]) -> Vec<u32> {
    data.iter()
        .filter(|&&x| x > 10)
        .map(|x| x * 2)
        .collect()
}

// ── Standard derive macros ─────────────────────────────────────────────────
// NOTE: These are built-in standard derives (Debug, Clone, PartialEq, Eq).
// They show that rust-analyzer expands derives generally, but don't test
// `procMacro.enable` — that requires a Cargo project with an external
// proc-macro crate (e.g., serde, thiserror) as a dependency.
//
// To test procMacro.enable, add to Cargo.toml:
//   [dependencies]
//   serde = { version = "1", features = ["derive"] }
// then replace `#[derive(Debug)]` below with `#[derive(Serialize, Deserialize)]`.

#[derive(Debug, Clone, PartialEq, Eq)]
struct Config {
    host: String,
    port: u16,
    tls: bool,
}

// ── Clippy-check diagnostics ───────────────────────────────────────────────

/// Clippy should warn about this unnecessary pass-by-value
fn log_value(s: String) {
    //                                          ^  clippy: `s` is passed by value but not consumed
    println!("value: {s}");
}

// ── Closing-brace hints (control flow) ─────────────────────────────────────

/// closingBraceHints should show the expression type after `}`
fn classify(n: i32) -> &'static str {
    let label = if n > 0 {
        "positive"
    } else if n < 0 {
        "negative"
    } else {
        "zero"
    }; // <- hint: &'static str
    label
}

// ── Full integration (multi-feature) ───────────────────────────────────────

#[derive(Debug)]
struct Cache {
    store: HashMap<String, Vec<u8>>,
}

impl Cache {
    fn new() -> Self {
        Self {
            store: HashMap::new(),
        }
    }

    fn insert(&mut self, key: &str, val: Vec<u8>) {
        self.store.insert(key.to_owned(), val);
    }

    fn get(&self, key: &str) -> Option<&[u8]> {
        self.store.get(key).map(|v| v.as_slice())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_input() {
        assert!(parse_input("hello").is_ok());
        assert!(parse_input("").is_err());
    }

    #[test]
    fn test_cache() {
        let mut cache = Cache::new();
        cache.insert("key1", vec![1, 2, 3]);
        assert_eq!(cache.get("key1"), Some(&[1u8, 2, 3][..]));
        assert_eq!(cache.get("missing"), None);
    }
}
