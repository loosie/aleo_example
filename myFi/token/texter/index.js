import { encodeString, encodeStringFixedLength } from "./encoder.js";
import { decodeBytes, decodeBytesFixedLength } from "./decoder.js";


// Example usage
const name = "WonToken";
const symbol = "WT";

const encodedName = encodeStringFixedLength(name, 24);
const encodedSymbol = encodeStringFixedLength(symbol, 8);

console.log(encodedName); // Uint8Array representation of "WonToken"
console.log(encodedSymbol); // Uint8Array representation of "WT"

// Assuming you retrieve these encoded values from the contract:
const decodedName = decodeBytesFixedLength(encodedName, 24);
const decodedSymbol = decodeBytesFixedLength(encodedSymbol, 8);

console.log(decodedName); // "WonToken"
console.log(decodedSymbol); // "WT"
