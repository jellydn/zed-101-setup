// Rust example for testing rust-analyzer LSP features.
// Uncomment the rust-analyzer block in settings.json's "lsp" section to test.
#![allow(dead_code)]

use std::collections::HashMap;

fn parse_input(raw: &str) -> Result<(), String> {
    if raw.is_empty() {
        return Err("empty input".into());
    }
    Ok(())
}

fn process_pair((left, right): (u32, &str)) -> String {
    format!("{left}:{right}")
}

fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

struct RefKeeper<'a> {
    value: &'a str,
}

fn score_items(data: &[u32]) -> Vec<u32> {
    data.iter().filter(|&&x| x > 10).map(|x| x * 2).collect()
}

#[derive(Debug, Clone, PartialEq, Eq)]
struct Config {
    host: String,
    port: u16,
    tls: bool,
}

fn log_value(s: String) {
    println!("value: {s}");
}

fn classify(n: i32) -> &'static str {
    let label = if n > 0 {
        "positive"
    } else if n < 0 {
        "negative"
    } else {
        "zero"
    };
    label
}

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
