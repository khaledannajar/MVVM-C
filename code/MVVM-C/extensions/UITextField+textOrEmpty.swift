//
//  UITextField+textOrEmpty.swift
//  Muqeem
//
//  Created by Naif Alrashed on 14/07/2019.
//  Copyright © 2019 ELM. All rights reserved.
//

import UIKit

extension UITextField {
    var textOrEmpty: String {
        set { text = newValue }
        get { return text ?? "" }
    }
    enum PaddingSide {
          case left(CGFloat)
          case right(CGFloat)
          case both(CGFloat)
      }

      func addPadding(_ padding: PaddingSide) {

          self.leftViewMode = .always
          self.layer.masksToBounds = true


          switch padding {

          case .left(let spacing):
              let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
              self.leftView = paddingView
              self.rightViewMode = .always

          case .right(let spacing):
              let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
              self.rightView = paddingView
              self.rightViewMode = .always

          case .both(let spacing):
              let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
              // left
              self.leftView = paddingView
              self.leftViewMode = .always
              // right
              self.rightView = paddingView
              self.rightViewMode = .always
          }
      }  
}
