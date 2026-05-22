use nvim_oxi::Result;
use nvim_oxi::serde::{DeserializeError, Serializer};
use nvim_oxi::{Dictionary, Function, Object};
use serde::Serialize;
use std::fs;

#[nvim_oxi::plugin]
fn taohua() -> Dictionary {
    let parse_fn: Function<String, Result<Object>> = Function::from_fn(parse_toml);
    Dictionary::from_iter([("parse_toml", parse_fn)])
}

fn parse_toml(filepath: String) -> Result<Object> {
    let contents = fs::read_to_string(&filepath).map_err(|e| {
        nvim_oxi::api::Error::Other(format!("Failed to read file {}: {}", filepath, e))
    })?;

    let toml_value: toml::Value = toml::from_str(&contents).map_err(|e| {
        nvim_oxi::Error::Deserialize(DeserializeError::Custom {
            msg: format!("Failed to parse TOML file {} with error: {}", filepath, e),
        })
    })?;

    let obj = toml_value
        .serialize(Serializer::new())
        .map_err(|e| nvim_oxi::Error::ObjectConversion(e.into()))?;

    Ok(obj)
}
