// Encode a string to a Uint8Array
export function encodeString(inputString) {
    const encoder = new TextEncoder();
    return encoder.encode(inputString);
}

export function encodeStringFixedLength(inputString, fixedLength) {
    let encoded = encodeString(inputString);

    let fixedArray = new Uint8Array(fixedLength);
    fixedArray.set(encoded.slice(0, fixedLength), 0);
    return fixedArray;
}

// Example usage
// const name = "WonToken";
// const symbol = "WT";

// const encodedName = encodeString(name);
// const encodedSymbol = encodeString(symbol);

// console.log(encodedName); // Uint8Array representation of "WonToken"
// console.log(encodedSymbol); // Uint8Array representation of "WT"

// // Assuming you retrieve these encoded values from the contract:
// const decodedName = decodeBytes(encodedName);
// const decodedSymbol = decodeBytes(encodedSymbol);

// console.log(decodedName); // "WonToken"
// console.log(decodedSymbol); // "WT"
