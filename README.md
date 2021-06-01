# Zwallet

MyMonee is an app that help you manage your finance, two main feature of this app are Spending tracking, and dream notes. spending tracking is to track any finance transaction you make and dream notes are note to track if whether you are able to purchase your dream or not based on your current balance.

This app use MVC as its design pattern and using iOS 14.4 as minimum SDK.

## Install

To import this project you only need to clone this repository then open MyMonee.xcodeproj using XCode

## Feature

Some feature and scene in this app:

* Home

    [![Home](https://i.postimg.cc/Yq9RffTM/simulator-screenshot-5799-E74-F-8-EEF-4-D16-9-EED-36-E34700-A111.png)](Home)

    * Add Transaction, Edit Transaction

        [![transactions](https://i.postimg.cc/J0BnMFGR/Screen-Shot-2021-06-01-at-16-26-03.png)](Homes)

* Dream

    [![dream](https://i.postimg.cc/9QBy6D6J/simulator-screenshot-52-A4116-E-628-F-446-B-A5-CC-A38-DB6-F4-F414.png)](Dream)

    * Add Dream, Edit Dream, Dream Archieved

        [![dreams](https://i.postimg.cc/0QGvnqMM/Screen-Shot-2021-06-01-at-16-31-58.png)](Dreams)

* Profile

    [![profile](https://i.postimg.cc/65t3DMBx/simulator-screenshot-39-F402-C1-3096-4-E4-F-A9-DB-7-F6-D580-C2-BC9.png)](Profile)


## Usage
Some usage of this app:

* View, is a component that build the user interface of the app, some view are used are UILabel, UIView, UITable, UICell, UIImage, etc.

* Class, is a object blueprint, so that is object created from this class will have similar attribute, just with different value

* Struct, just like class but usually used to describie fix object. The difference between class and struct is if the Class were assigned into a variable, swift will copy it by reference so if something changed in new variable the old variable will be changed too. But it does not happen with stuct because unlike class, when struct assigned into new variable swift will do something called copy by value.

* Protocol, is a contract to make sure any claass that implement this protocol will have the same attributes described in protocol. In this project mostly protocol were use to create some like abstraction like delegate so if a class cannot do some task it can assign the tast to another class that able to do the task.

* Extension, is an extend of a class, usually used when implement some protocol to some class to make the code easier to read.