export const parseMintTokenResult = (resultString) => {
    const cleanString = resultString.replace(/(\s|\n)/g, '');


    const ownerMatch = cleanString.match(/owner:(.*?\.private)/);
    const amountMatch = cleanString.match(/amount:(.*?\.private)/);
    const idMatch = cleanString.match(/id:(.*?\.private)/);
    const nonceMatch = cleanString.match(/_nonce:(.*?group\.public)/);

    return {
        owner: ownerMatch ? ownerMatch[1] : null,
        amount: amountMatch ? amountMatch[1] : null,
        id: idMatch ? idMatch[1] : null,
        _nonce: nonceMatch ? nonceMatch[1] : null,
    };
};


export const tokenMetatdata = {
    won: {
        id: "1u64",
        name: [87, 111, 110, 84, 111, 107, 101, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        symbol: [87, 84, 0, 0, 0, 0, 0, 0]
    },
    jong: {
        id: "2u64",
        name: [74, 111, 110, 103, 84, 111, 107, 101, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        symbol: [74, 84, 0, 0, 0, 0, 0, 0]
    }
}