// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import Foundation

public protocol Solend {
    func getCollateralAccounts(rpcURL: String, owner: String) async throws -> [SolendCollateralAccount]

    /// Fetch market info
    ///
    /// - Parameters:
    ///   - tokens: Token symbol. Example: USDT, USDC, SOL
    ///   - pool: Solend pool. Example: main
    func getMarketInfo(tokens: [String], pool: String) async throws -> [(token: String, marketInfo: SolendMarketInfo)]

    /// Fetch user deposit
    ///
    /// - Parameters:
    ///   - owner: user's wallet address
    ///   - poolAddress: lending market address
    func getUserDeposits(owner: String, poolAddress: String) async throws -> [SolendUserDeposit]

    /// Fetch user deposit for symbol
    ///
    /// - Parameters:
    ///   - owner: user's wallet address
    ///   - symbol: token symbol. Example: USDT, USDC, SOL
    ///   - poolAddress: lending market address
    /// - Returns:
    /// - Throws:
    func getUserDepositBySymbol(owner: String, symbol: String, poolAddress: String) async throws -> SolendUserDeposit

    func getDepositFee(
        rpcUrl: String,
        owner: String,
        tokenAmount: UInt64,
        tokenSymbol: String
    ) async throws -> SolendDepositFee

    /// Create a deposit transaction
    ///
    /// - Parameters:
    ///   - solanaRpcUrl: Solana rpc endpoint
    ///   - relayProgramId: Relay program address
    ///   - amount: amount of deposit
    ///   - symbol: token symbol. Example: USDC, SOL
    ///   - ownerAddress: user's wallet address
    ///   - environment:
    ///   - lendingMarketAddress: solend lending market address
    ///   - blockHash: latest solana block hash
    ///   - freeTransactionsCount: the number of free transaction, that be payed by Fee Relay. ``needToUseRelay`` have be true
    ///   - needToUseRelay: the indicator of usage fee relay
    ///   - payInFeeToken: the token in user's wallet that will be used for cover fee
    ///   - feePayerAddress: the fee payer address.
    /// - Returns: Stringify transaction
    func createDepositTransaction(
        solanaRpcUrl: String,
        relayProgramId: String,
        amount: UInt64,
        symbol: String,
        ownerAddress: String,
        environment: SolendEnvironment,
        lendingMarketAddress: String,
        blockHash: String,
        freeTransactionsCount: UInt32,
        needToUseRelay: Bool,
        payInFeeToken: SolendPayFeeInToken,
        feePayerAddress: String
    ) async throws -> [SolanaRawTransaction]

    /// Create a withdraw transaction
    ///
    /// - Parameters:
    ///   - solanaRpcUrl: Solana rpc endpoint
    ///   - relayProgramId: Relay program address
    ///   - amount: amount of deposit
    ///   - symbol: token symbol. Example: USDC, SOL
    ///   - ownerAddress: user's wallet address
    ///   - environment:
    ///   - lendingMarketAddress: solend lending market address
    ///   - blockHash: latest solana block hash
    ///   - freeTransactionsCount: the number of free transaction, that be payed by Fee Relay. ``needToUseRelay`` have be true
    ///   - needToUseRelay: the indicator of usage fee relay
    ///   - payInFeeToken: the token in user's wallet that will be used for cover fee
    ///   - feePayerAddress: the fee payer address.
    /// - Returns: Stringify transaction
    func createWithdrawTransaction(
        solanaRpcUrl: String,
        relayProgramId: String,
        amount: UInt64,
        symbol: String,
        ownerAddress: String,
        environment: SolendEnvironment,
        lendingMarketAddress: String,
        blockHash: String,
        freeTransactionsCount: UInt32,
        needToUseRelay: Bool,
        payInFeeToken: SolendPayFeeInToken,
        feePayerAddress: String
    ) async throws -> [SolanaRawTransaction]
}
