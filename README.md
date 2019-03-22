# BASE PROJECT 
This project is a mookup for future projects and contains the basic structure to follow and many auxiliar classes. 

This project uses [Carthage](https://github.com/Carthage/Carthage) for the following Frameworks:
- IQKeyboardManager
- Lottie

before running this project you should run 

```shell
[base-project/]
> carthage update
```

Contains the following modules with examples of possible applications

## Payments

#### Register new card

Basic form to register a card using a [Payments API](http://159.65.233.218/docs). It creates a token for the card in the form.

#### Registered card

Basic list of the registered cards that belongs to a customer 

#### Available Requests

Examples of the available requests in the Payments API.

## Auxiliar Classes

#### Main Coordinator

This class helps to control the app flow moving from one View Controller to another View Controller.
Ir conforms the `Coordinator` protocol and should be configured in the AppDelegate when the app starts

This is just a mookup to create a coordinator, so you should create always your own MainCoordinator.

The file `Coodinator` contains the Coordinator protocol so it could be reused.

#### HandlerError

This class helps to hanlde any error recieved from the server, it has an instance of the Main Coordinator so an alert an be shown whenever is necessary.
The Alert show is an instance of the class **AlertViewController** and you can display an alert with a custom message if the error is not from the server.

It depends on the enum `ErrorType` which contains the classic error cases and it can be modified dependind on the project.

In order to use this class you need to copy the following classes:

- MainCoordinator (this should be created for the project specific)
- ErrorType.swift
- AlertViewController.swift (with respective AlertViewController.xib)

Here is an example of how in can be used

```swift
// This is an example for when you receive an error from the server in the response body
HandlerError.shared.handle(withError: ErrorType(responseError: data as? [String : Any] ?? [:], serverError: nil))

// This is an example for when you receive an explicit error from the server
HandlerError.shared.handle(withError: ErrorType(responseError: nil, serverError: error))

// This is an example if you need to show an specific error thas is not from the server
HandlerError.shared.showAlert(with: "Debes registrar una tarjeta primero 🥺", delegate: self)

```

#### PaymentRouter 

This class contains all the available requests in the [Payments API](http://159.65.233.218/docs) and its properties (methods, paths, urlrequest).
It contains the method `performRequest` that returns the server response of type `Any?` and should be cast to the response type like in the example above.

```swift

let request = PaymentRouter.singleChargeByAmount(
                [
                    "description": "500 gems - Clash Royale",
                    "token_id": tokenId,
                    "amount": 550.55
                ])
request.performRequest { (response) in
    guard let validResponse = response as? CreateSingleChargeResponse else {return}
}
```

In order to use this class you need to copy the following classes:

- Response Models/
    - CreateSingleChargeResponse.swift
    - ClientInformationResponse.swift
    - GenerateClientResponse.swift
- HandlerError.swift (and all the required classes)
- ProjectSingleton.swift (This should be configured for the project)
- RequestMethod.swift

#### ConektaClient

This class helps to create a token directly with Conekta. You can create it like in example above.

```swift
 ConektaClient.shared.generateToken(cardObject: card, delegate: delegate as! UIViewController) { (token) in
    // Do wathever you want with the token 
 }
```

In order to use this class you need to copy the following classes:

- HandlerError.swift (and all the required classes)
- Conekta Files/ (all the files inside the folder)
- Card.swift
- CardBrand.swift
- Dynamic.swift
- Bounds.swift

## Documentation

Se puede consultar la documentaci\'on creada con [Jazzy](https://github.com/realm/jazzy) en el archivo `docs/index.html`
 



