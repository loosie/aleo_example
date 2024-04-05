program wontoken.aleo;

struct tokenMetadata:
    id as u64;
    name as [u8; 24u32];
    symbol as [u8; 8u32];

record token:
    owner as address.private;
    amount as u64.private;
    id as u64.private;


mapping aleo_token_metadata:
	key as u64.public;
	value as tokenMetadata.public;

function mint:
    input r0 as u64.private;
    input r1 as address.public;
    input r2 as u64.public;
    input r3 as tokenMetadata.private;
    cast r1 r2 r0 into r4 as token.record;
    cast r0 r3.name r3.symbol into r5 as tokenMetadata;
    async mint r0 r5 into r6;
    output r4 as token.record;
    output r6 as wontoken.aleo/mint.future;

finalize mint:
    input r0 as u64.public;
    input r1 as tokenMetadata.public;
    set r1 into aleo_token_metadata[r0];


function transfer_private:
    input r0 as token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 r0.id into r4 as token.record;
    cast r1 r2 r0.id into r5 as token.record;
    output r4 as token.record;
    output r5 as token.record;
