package org.ayiyikoh.util

import org.ayiyikoh.util.RSA.buildKeyPair


fun String.encrypt():String{
    // generate public and private keys
    val keyPair = buildKeyPair()
    val pubKey = keyPair.public
    val privateKey = keyPair.private

    // encrypt the string
    val encrypted = RSA.encrypt(privateKey, "This is a secret message")
    return String(encrypted)  // <<encrypted string>>
}

fun String.decrypt():String{
    // generate public and private keys
    val keyPair = buildKeyPair()
    val pubKey = keyPair.public
    val privateKey = keyPair.private

    // decrypt the string
    val secret = RSA.decrypt(pubKey, this.toByteArray())
    return  String(secret)     // This is a secret string
}