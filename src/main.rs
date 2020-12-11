use tikv_client::{RawClient, Result};

#[tokio::main]
async fn main() -> Result<()> {
    let client = RawClient::new(vec!["http://pd.tikv:2379"]).await?;
    client
        .put("key".to_owned(), "itreallywerks".to_owned())
        .await?;
    let value = client.get("key".to_owned()).await.unwrap().unwrap();
    println!("Wrote and fetched: {}", String::from_utf8(value).unwrap());
    Ok(())
}
