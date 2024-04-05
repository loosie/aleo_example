// Decode a Uint8Array back to a string
export function decodeBytes(inputBytes) {
    const decoder = new TextDecoder();
    return decoder.decode(inputBytes);
}

export function decodeBytesFixedLength(inputBytes, fixedLength) {
    let decoded = decodeBytes(inputBytes);
    return decoded.slice(0, fixedLength);
}