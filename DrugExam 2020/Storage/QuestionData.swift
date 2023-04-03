//
//  QuestionData.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 3/4/23.
//

import Foundation
import SQLite3

class QuestionData: ObservableObject {
    
    let dbName: String = "QuestionData.sqlite"
    var db: OpaquePointer?
    
    // MARK: - Tables
    static let TABLE_QUESTION = "Question"
    
    // MARK: - Question Column
    static let COL_QUESTION_NO = "questionNo"
    static let COL_QUESTION_NAME = "questionName"
    static let COL_CHOICE_A = "choiceA"
    static let COL_CHOICE_B = "choiceB"
    static let COL_CHOICE_C = "choiceC"
    static let COL_CHOICE_D = "choiceD"
    static let COL_CORRECT_ANS = "correctAns"
    static let COL_CHOSEN_ANS = "chosenAns"
    static let COL_BOOKMARK = "bookmark"
    
    init() {
        
        self.db = createDatabase()
        self.createQuestionTable()
    }
    
    func createDatabase() -> OpaquePointer? {
        
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbName)
        print("filePath \(filePath)")
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating QuestionData DB")
            return nil
        } else {
            print("Question Database has been created with path \(dbName)")
            UserDefaults.standard.set(true, forKey: "databaseCreated")
            print("UserDefaults.databaseCreated :: \(UserDefaults.standard.bool(forKey: "databaseCreated"))")
            return db
        }
    }
    
    // Create Question Table
    func createQuestionTable() {
        let query = """
         CREATE TABLE IF NOT EXISTS \(QuestionData.TABLE_QUESTION)
         (ID INTEGER PRIMARY KEY AUTOINCREMENT,
        \(QuestionData.COL_QUESTION_NO) TEXT,
        \(QuestionData.COL_QUESTION_NAME) TEXT,
        \(QuestionData.COL_CHOICE_A) TEXT,
        \(QuestionData.COL_CHOICE_B) TEXT,
        \(QuestionData.COL_CHOICE_C) TEXT,
        \(QuestionData.COL_CHOICE_D) TEXT,
        \(QuestionData.COL_CORRECT_ANS) TEXT,
        \(QuestionData.COL_CHOSEN_ANS) TEXT,
        \(QuestionData.COL_BOOKMARK) INTEGER
        )
        """
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Question Table created SUCCESSFULLY")
            } else {
                print("Question Table creation FAILED")
            }
        } else {
            print("FAILED to create Question Table")
        }
        sqlite3_finalize(statement)
    }
    
    
    // MARK: - Insert in Question table
    func insertQuestion(qes: QuestionInfo) {
        
        let query = """
        INSERT INTO  \(QuestionData.TABLE_QUESTION) (
        \(QuestionData.COL_QUESTION_NO),
        \(QuestionData.COL_QUESTION_NAME),
        \(QuestionData.COL_CHOICE_A),
        \(QuestionData.COL_CHOICE_B),
        \(QuestionData.COL_CHOICE_C),
        \(QuestionData.COL_CHOICE_D),
        \(QuestionData.COL_CORRECT_ANS),
        \(QuestionData.COL_CHOSEN_ANS),
        \(QuestionData.COL_BOOKMARK)
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(statement, 1, ((qes.questionNo ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, ((qes.questionName ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, ((qes.choiceA ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, ((qes.choiceB ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, ((qes.choiceC ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 6, ((qes.choiceD ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 7, ((qes.correctAns ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 8, ((qes.chosenAns ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 9, Int32(qes.bookmark ?? 0))
            
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Question Data inserted successfully")
            } else {
                print("Question Data not inserted in the Table")
            }
        } else {
            print("Question insert Query is not as per requirement")
        }
        sqlite3_finalize(statement)
    }
    
    
    // MARK: - Get Customer
    func getQuestion() -> [QuestionInfo] {
        
        var qesList = [QuestionInfo]()
        var statement: OpaquePointer? = nil
        let query = "SELECT * FROM Question"
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let questionNo = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                let questionName = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                let choiceA = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                let choiceB = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                let choiceC = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                let choiceD = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                let correctAns = String(describing: String(cString: sqlite3_column_text(statement, 7)))
                let chosenAns = String(describing: String(cString: sqlite3_column_text(statement, 8)))
                let bookmark = Int(sqlite3_column_double(statement, 9))
                
                
                var qes = QuestionInfo()
                qes.questionNo = questionNo
                qes.questionName = questionName
                qes.choiceA = choiceA
                qes.choiceB = choiceB
                qes.choiceC = choiceC
                qes.choiceD = choiceD
                qes.correctAns = correctAns
                qes.chosenAns = chosenAns
                qes.bookmark = bookmark
                
                qesList.append(qes)
                
                print("qes_size--: \(qes.questionNo)")
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(statement)
        print("Question size : \(qesList.count)")
        return qesList
    }
    
    
    // MARK: - Delete Question
    func deleteAllQuestion() {
        let query = "DELETE FROM \(QuestionData.TABLE_QUESTION)"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Customer Data delete success")
            } else {
                print("Customer Data is not deleted from table")
            }
        }
    }
}
