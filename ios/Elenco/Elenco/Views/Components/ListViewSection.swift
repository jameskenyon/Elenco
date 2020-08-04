//
//  ListViewSection.swift
//  Elenco
//
//  Created by James Bernhardt on 04/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

struct ListViewSection<SectionContent> where SectionContent: Identifiable {
    var title: String
    var content: [SectionContent]
}
