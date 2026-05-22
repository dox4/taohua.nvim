use nvim_oxi::serde::Serializer;
use nvim_oxi::{Dictionary, Function, Object};
use serde::Serialize;
use std::fs;

#[nvim_oxi::plugin]
pub fn taohua() -> Dictionary {
    let parse_fn: Function<String, Dictionary> = Function::from_fn(parse_toml);
    Dictionary::from_iter([("parse_toml", parse_fn)])
}

fn parse_toml(filepath: String) -> Dictionary {
    let contents = match fs::read_to_string(&filepath) {
        Ok(contents) => contents,
        Err(err) => {
            return Dictionary::from_iter([
                ("ok", Object::from(false)),
                (
                    "error",
                    Object::from(format!("Failed to read file {}: {}", filepath, err)),
                ),
            ]);
        },
    };

    let toml_value: toml::Value = match toml::from_str(&contents) {
        Ok(value) => value,
        Err(err) => {
            return Dictionary::from_iter([
                ("ok", Object::from(false)),
                (
                    "error",
                    Object::from(format!(
                        "Failed to parse TOML file {} with error: {}",
                        filepath, err
                    )),
                ),
            ]);
        },
    };

    let obj = match toml_value.serialize(Serializer::new()) {
        Ok(obj) => obj,
        Err(err) => {
            return Dictionary::from_iter([
                ("ok", Object::from(false)),
                (
                    "error",
                    Object::from(format!(
                        "Failed to serialize TOML file {} with error: {}",
                        filepath, err
                    )),
                ),
            ]);
        },
    };

    Dictionary::from_iter([("ok", Object::from(true)), ("value", obj)])
}
