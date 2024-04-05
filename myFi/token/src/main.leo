program wontoken.aleo {
    struct tokenMetadata {
        id: u64,
        name: [u8; 24], 
        symbol: [u8; 8], 
    }

    record token {
        owner: address,
        amount: u64,
        id: u64,
    }

    mapping aleo_token_metadata: u64 => tokenMetadata;

    transition mint(tokenId: u64, public owner: address, public amount: u64, tokenMetadata: tokenMetadata) -> (token) {
        let newToken: token = token {
            owner: owner,
            amount: amount,
            id: tokenId
        };
        let newTokenMetadata: tokenMetadata = tokenMetadata {
            id: tokenId,
            name: tokenMetadata.name,
            symbol: tokenMetadata.symbol,
        };

        return (newToken) then finalize(tokenId, newTokenMetadata);
    }

    finalize mint (tokenId: u64, tokenMetadata: tokenMetadata) {
        Mapping::set(aleo_token_metadata, tokenId, tokenMetadata);    
    }

    transition transfer_private(sender: token, receiver: address, amount: u64) -> (token, token) {
        let difference: u64 = sender.amount - amount;
        let remaining: token = token {
            owner: sender.owner,
            amount: difference,
            id: sender.id
        };

        let transferred: token = token {
            owner: receiver,
            amount: amount,
            id: sender.id
        };

        return (remaining, transferred); 
    }
}
