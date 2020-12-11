use tikv_client::{Config, RawClient, Result};

#[tokio::main]
async fn main() -> Result<()> {
    let config = Config::default();
    let client = RawClient::new_with_config(vec!["127.0.0.1:2379"], config).await?;
    client.put("key".to_owned(), "value".to_owned()).await?;
    let value = client.get("key".to_owned()).await.unwrap().unwrap();
    println!("Hello, TiKV! {}", String::from_utf8(value).unwrap());
    Ok(())
}
