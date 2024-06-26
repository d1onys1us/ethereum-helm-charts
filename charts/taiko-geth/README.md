# taiko-geth

## Usage

### Update values

Replace the `jwt` in `values.yaml`. You could use OpenSSL like: 

```sh
openssl rand -hex 32 | tr -d "\n" > "jwt.hex"
```

You can also set other configuration values like the cpu / memory usage, and the network (`mainnet` or `hekla`).

### Install the chart

Install the chart:
```sh
helm install taiko-geth .
```
