//
// RecPow.swift
//
// Created by Noah Smith
// Created on 2025-05-06
// Version 1.0
// Copyright (c) 2025 Noah Smith. All rights reserved.
//
// The RecPow program will read a set of whole numbers from 'input.txt'.
// It will check if it is a valid whole number.
// If it is not a valid whole number, it will write an error message.
// It will then calculate the power of each valid whole number.
// Finally, it will write the results to 'output.txt'.

// Import foundation library
import Foundation

// Define error for invalid number
enum InputError: Error {
    case invalidNumber
}

// Function to calculate the power
func power(_ base: Int, _ exp: Int) -> Int {
    // Base case
    if exp == 0 {
        // Return 1 because x^0 = 1
        return 1
    } else {
        // Recursive case
        return base * power(base, exp - 1)
    }
}

// Greeting and program description
print("Welcome to the power program!")
print("This program will read a set of whole numbers from 'input.txt'.")
print("It will check if it is a valid whole number.")
print("If it is not a valid whole number, it will write an error message.")
print("It will then calculate the power of each valid whole number.")
print("It will write the results to 'output.txt'.")

// Initialize output string
var outputStr = ""

// Open input file for reading
let inputPath = "./input.txt"

// Create output file
let outputPath = "./output.txt"

do {
    // Read all lines, one by one
    let fileContent = try String(contentsOfFile: inputPath)

    // Split the file content into lines
    let lines = fileContent.components(separatedBy: .newlines)

    // Initialize index
    var index = 0

    // While it has not reached the end of the file
    while index < lines.count {
        // Set the line to current line
        let line = lines[index]

        // Split the line into an array of numbers
        let numbers = line.split(separator: " ")

        // Ensure the line contains at least two numbers
        if numbers.count >= 2 {
            do {
                // Convert the base and exponent from a string to an integer
                if let base = Int(numbers[0]), let exp = Int(numbers[1]) {
                    // Check if it is not a whole number
                    if base < 0 || exp < 0 {
                        // Write error message
                        outputStr += "'\(line)' contains invalid whole numbers.\n"
                    } else {
                        // Function call
                        let powerResult = power(base, exp)

                        // Write the power result to the output string
                        outputStr += "\(base) ^ \(exp) = \(powerResult)\n"
                    }
                } else {
                    throw InputError.invalidNumber
                }
            } catch {
                // Write error message
                outputStr += "'\(line)' contains invalid whole numbers.\n"
            }
        } else {
            // Handle lines with insufficient numbers
            outputStr += "'\(line)' does not contain enough numbers.\n"
        }

        // Increment index
        index += 1
    }

    // Write the output string to the output file
    try outputStr.write(toFile: outputPath, atomically: true, encoding: .utf8)

    // Display success message
    print("\nSuccessfully wrote to file 'output.txt'.")
} catch {
    // Display file error message
    print("A file error occurred.")
}
