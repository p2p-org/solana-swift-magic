// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import Foundation

public class RecipientSearchServiceMock: RecipientSearchService {
    let result: RecipientSearchResult

    public init(result: RecipientSearchResult) { self.result = result }

    public func search(input _: String, state _: UserWalletState) async -> RecipientSearchResult { result }
}
