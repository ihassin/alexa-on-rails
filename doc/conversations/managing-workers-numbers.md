```sequence
title Managing worker's numbers

Itamar->Echo: Tell buildit to add a number for Itamar
Echo->Rails: Get Itamar's number
Rails->Echo: None
Echo->Itamar: What is the number for Itamar?
Itamar->Echo: +197327198349
Echo->Rails: Set Itamar's number
Echo->Rails: Get Itamar's number
Rails->Echo: +197327198349
Echo->Itamar: The number for Itamar is +197327198349

Itamar->Echo: Tell buildit to remove Itamar's number
Echo->Rails: Get Itamar's number
Rails->Echo: +197327198349
Echo->Itamar: Remove Itamar's number?
Itamar->Echo: Yes
Echo->Rails: Set Itamar's number
Echo->Rails: Get Itamar's number
Rails->Echo: None
Echo->Itamar: Itamar no longer has a number

Itamar->Echo: Tell buildit to m modify Itamar's number
Echo->Rails: Get Itamar's number
Rails->Echo: +197327198349
Echo->Itamar: What is Itamar's new number?
Itamar->Echo: +197327198348
Echo->Rails: Set Itamar's number
Echo->Rails: Get Itamar's number
Rails->Echo: +197327198348
Echo->Itamar: Itamar's number has been modified
```
