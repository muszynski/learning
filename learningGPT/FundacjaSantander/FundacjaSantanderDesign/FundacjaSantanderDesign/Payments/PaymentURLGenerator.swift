//
//  PaymentURLGenerator.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 01/06/2023.
//

import Foundation
import CommonCrypto

struct PaymentURLGenerator {
    var idSellers : Int
    var amount: String
    var description: String
    var crc: String
    var securityCode : String
    var name : String
    var email : String
    var phone : String?

    var encodedDescription: String {
        return description.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    var encodedName: String {
        return name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }

    var md5sum: String {
        return calculateMD5(string: "\(idSellers)&\(amount)&\(crc)&\(securityCode)")
    }

    var url: String {
//        return "https://secure.tpay.com/?id=\(idSellers)&amount=\(amount)&crc=\(crc)&description=\(encodedDescription)&md5sum=\(md5sum)"
        return "https://secure.tpay.com/?id=\(idSellers)&amount=\(amount)&crc=\(crc)&description=\(encodedDescription)&md5sum=\(md5sum)&name=\(encodedName)&email=\(email)"
    }

    private func calculateMD5(string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: .utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate()
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
}




