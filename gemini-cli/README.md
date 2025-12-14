# Gemini CLI - Image Description Tool

Menggunakan `@google/gemini-cli` untuk describe image.

## Install Gemini CLI

```bash
npm install -g @google/gemini-cli
```

Lalu authenticate:

```bash
gemini
```

## Usage

### Dari file image

```bash
./describe-image.sh /path/to/image.jpg
./describe-image.sh /path/to/image.jpg "What text is in this image?"
```

### Dari base64 (untuk n8n)

```bash
echo "BASE64_DATA" | ./describe-image.sh - "Describe this image"
```

## n8n Integration

Di n8n SSH node:

```bash
echo "{{ $json.base64_image }}" | /root/sandbox/gemini-cli/describe-image.sh - "Describe this image"
```
