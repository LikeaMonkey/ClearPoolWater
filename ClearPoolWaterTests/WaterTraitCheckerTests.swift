//
//  WaterTraitCheckerTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

import Testing

@testable import ClearPoolWater

struct WaterTraitCheckerTests {
    @Test func goodPh() async {
        let ph = WaterTraitFactory.create(type: .ph, value: 7.2)
        let result = WaterTraitChecker.check(trait: ph)
        #expect(result == .normal)
    }

    @Test func lowPh() async {
        let ph = WaterTraitFactory.create(type: .ph, value: 6.8)
        let result = WaterTraitChecker.check(trait: ph)
        #expect(result == .belowMinimum)
    }

    @Test func highPh() async {
        let ph = WaterTraitFactory.create(type: .ph, value: 8.2)
        let result = WaterTraitChecker.check(trait: ph)
        #expect(result == .aboveMaximum)
    }

    @Test func goodAlkalinity() async {
        let alkalinity = WaterTraitFactory.create(type: .alkalinity, value: 100)
        let result = WaterTraitChecker.check(trait: alkalinity)
        #expect(result == .normal)
    }

    @Test func lowAlkalinity() async {
        let alkalinity = WaterTraitFactory.create(type: .alkalinity, value: 70)
        let result = WaterTraitChecker.check(trait: alkalinity)
        #expect(result == .belowMinimum)
    }

    @Test func highAlkalinity() async {
        let alkalinity = WaterTraitFactory.create(type: .alkalinity, value: 130)
        let result = WaterTraitChecker.check(trait: alkalinity)
        #expect(result == .aboveMaximum)
    }

    @Test func goodChlorine() async {
        let chlorine = WaterTraitFactory.create(type: .chlorine, value: 2)
        let result = WaterTraitChecker.check(trait: chlorine)
        #expect(result == .normal)
    }

    @Test func lowChlorine() async {
        let chlorine = WaterTraitFactory.create(type: .chlorine, value: 0.3)
        let result = WaterTraitChecker.check(trait: chlorine)
        #expect(result == .belowMinimum)
    }

    @Test func highChlorine() async {
        let chlorine = WaterTraitFactory.create(type: .chlorine, value: 3.5)
        let result = WaterTraitChecker.check(trait: chlorine)
        #expect(result == .aboveMaximum)
    }

    @Test func goodTemperature() async {
        let temperature = WaterTraitFactory.create(type: .temperature, value: 27)
        let result = WaterTraitChecker.check(trait: temperature)
        #expect(result == .normal)
    }

    @Test func lowTemperature() async {
        let temperature = WaterTraitFactory.create(type: .temperature, value: 22)
        let result = WaterTraitChecker.check(trait: temperature)
        #expect(result == .belowMinimum)
    }

    @Test func highTemperature() async {
        let temperature = WaterTraitFactory.create(type: .temperature, value: 30)
        let result = WaterTraitChecker.check(trait: temperature)
        #expect(result == .aboveMaximum)
    }
}
