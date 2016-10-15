//
//  AnimatedValidatorSwiftTests.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/29/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Nimble
import Quick
import KIF
@testable import animated_validator_swift

class ValidatorViewControllerTest: QuickSpec {
     //SpecBegin(ValidatorViewController)
    override func spec() {
        
        let tester = KIFUITestActor(inFile: #file, atLine: #line, delegate: self)!
        
        let submitButton =  tester.waitForView(withAccessibilityLabel: Constants.SUBMITBUTTON) as! UIButton
        
        describe("submit button:") {
            
            it("Should only enable button when all fields are valid") {
                
                
                tester.waitForTappableView(withAccessibilityLabel: Constants.EMAILTEXTFIELD)
                tester.tapView(withAccessibilityLabel: Constants.EMAILTEXTFIELD)
                tester.enterText("susan@flatironschool.com", intoViewWithAccessibilityLabel: Constants.EMAILTEXTFIELD)
                
                expect(submitButton.isEnabled).to(beFalse())
                
                tester.tapView(withAccessibilityLabel: Constants.EMAILCONFIRMTEXTFIELD)
                tester.enterText("susan@flatironschool.com", intoViewWithAccessibilityLabel: Constants.EMAILCONFIRMTEXTFIELD)
                
                expect(submitButton.isEnabled).to(beFalse())
                
                tester.tapView(withAccessibilityLabel: Constants.PHONETEXTFIELD)
                tester.enterText("6466440584", intoViewWithAccessibilityLabel: Constants.PHONETEXTFIELD)
                
                expect(submitButton.isEnabled).to(beFalse())
                
                tester.tapView(withAccessibilityLabel: Constants.PASSWORDTEXTFIELD)
                tester.enterText("myPassword1", intoViewWithAccessibilityLabel: Constants.PASSWORDTEXTFIELD)
                
                expect(submitButton.isEnabled).to(beFalse())
                
                tester.tapView(withAccessibilityLabel: Constants.PASSWORDCONFIRMTEXTFIELD)
                tester.enterText("myPassword1\n", intoViewWithAccessibilityLabel: Constants.PASSWORDCONFIRMTEXTFIELD)
                
                //tester.tapView(withAccessibilityLabel: Constants.EMAILTEXTFIELD)
                
                expect(submitButton.isEnabled).to(beTrue())
            }
        }
    }
}


extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

