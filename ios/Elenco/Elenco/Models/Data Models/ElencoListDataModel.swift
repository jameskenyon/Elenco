//
//  ElencoListDataModel.swift
//  Elenco
//
//  Created by James Kenyon on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit

class ElencoListDataModel: ObservableObject {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Published var lists: [ElencoList] = []

}
