//
//  ContentViewSnapshotTest.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.12.24.
//

import SnapshotTesting
import Testing

@testable import ClearPoolWater

@MainActor
struct SnapshotTests {
    @Test func testContentViewSnapshot() {
        assertSnapshot(of: ContentView(), as: .image)
    }

    // MARK: Account

    @Test func testAccountViewSnapshot() {
        assertSnapshot(of: AccountView(), as: .image)
    }

    @Test func testLoginViewSnapshot() {
        assertSnapshot(of: LoginView(), as: .image)
    }

    @Test func testRegisterViewSnapshot() {
        assertSnapshot(of: RegisterView(), as: .image)
    }

    @Test func testConfirmPasswordTextFieldSnapshot() {
        let view = ConfirmPasswordTextField(password: .constant("asd"))
        assertSnapshot(of: view, as: .image)
    }

    @Test func testAccountPlanViewSnapshot() {
        let view = AccountPlanView(role: .user)
        assertSnapshot(of: view, as: .image)
    }

    @Test func testAccountInfoViewSnapshot() {
        let view = AccountInfoView(email: "test@test.com", role: .user)
        assertSnapshot(of: view, as: .image)
    }

    @Test func testAccountAvatarSnapshot() {
        let view = AccountAvatar(initial: "S")
        assertSnapshot(of: view, as: .image)
    }

    @Test func testUnitsPickerSnapshot() {
        assertSnapshot(of: UnitsPicker(), as: .image)
    }

    @Test func testTermsAndConditionsButtonSnapshot() {
        assertSnapshot(of: TermsAndConditionsButton(), as: .image)
    }

    @Test func testTemperaturePickerSnapshot() {
        assertSnapshot(of: TemperaturePicker(), as: .image)
    }

    @Test func testLanguagePickerSnapshot() {
        assertSnapshot(of: LanguagePicker(), as: .image)
    }

    @Test func testAppearancePickerSnapshot() {
        assertSnapshot(of: AppearancePicker(), as: .image)
    }

    @Test func testAccountSettingsViewSnapshot() {
        assertSnapshot(of: AccountSettingsView(), as: .image)
    }

    // MARK: Calculators

    @Test func testWaterBalanceCalculatorViewSnapshot() {
        assertSnapshot(of: WaterBalanceCalculatorView(), as: .image)
    }

    @Test func testPoolVolumeSectionSnapshot() {
        let view = PoolVolumeSection(poolVolumeValue: .constant(1))
        assertSnapshot(of: view, as: .image)
    }

    @Test func testDosageSectionSnapshot() {
        let dosage = ChemistryDosage(amount: 1, volume: 1, increasedValue: 1)
        let view = DosageSection(dosage: .constant(dosage))
        assertSnapshot(of: view, as: .image)
    }

    @Test func testCalculatorResultViewSnapshot() {
        let view = CalculatorResultView(resultValue: 10)
        assertSnapshot(of: view, as: .image)
    }

    @Test func testAdjustmentSectionSnapshot() {
        let view = AdjustmentSection(currentValue: .constant(1), targetValue: .constant(1.2))
        assertSnapshot(of: view, as: .image)
    }

    // MARK: Common

    @Test func testBackgroundViewSnapshot() {
        assertSnapshot(of: BackgroundView(), as: .image)
    }

    @Test func testEmailTextFieldSnapshot() {
        let view = EmailTextField(email: .constant("test@test.com"))
        assertSnapshot(of: view, as: .image)
    }

    @Test func testErrorViewSnapshot() {
        assertSnapshot(of: ErrorView(), as: .image)
    }

    @Test func testLoadableViewSnapshot() {
        let view = LoadableView(state: .loading, reloadAction: {}) {}
        assertSnapshot(of: view, as: .image)
    }

    @Test func testNumericTextFieldSnapshot() {
        let view = NumericTextField(value: .constant(1), range: 0...10)
        assertSnapshot(of: view, as: .image)
    }

    @Test func testPasswordTextFieldSnapshot() {
        let view = PasswordTextField(password: .constant("asd"))
        assertSnapshot(of: view, as: .image)
    }

    @Test func testSliderTextFieldSnapshot() {
        let view = SliderTextFieldView(value: .constant(1), range: 0...10, step: 1)
        assertSnapshot(of: view, as: .image)
    }

    @Test func testWaterParameterGaugeSnapshot() {
        let view = WaterParameterGauge(name: "Test", value: 1, range: 0...10, idealRange: 0...2)
        assertSnapshot(of: view, as: .image)
    }

    // MARK: Prediction

    @Test func testPredictionViewSnapshot() {
        assertSnapshot(of: PredictionView(), as: .image)
    }

    @Test func testPredictionResultViewSnapshot() {
        let prediction = ImagePrediction(classification: "test", confidence: 0.99)
        let view = PredictionResultView(prediction: prediction)
        assertSnapshot(of: view, as: .image)
    }

    @Test func testPredictionImageViewSnapshot() {
        let view = PredictionImageButton(
            image: .constant(nil),
            selectedCameraImage: .constant(nil),
            selectedPhoto: .constant(nil)
        )
        assertSnapshot(of: view, as: .image)
    }

    @Test func testPredictButtonSnapshot() {
        let view = PredictButton(isLoading: false, isDisabled: false) {}
        assertSnapshot(of: view, as: .image)
    }

    // MARK: Pool
    // TODO: Add Pool tab related views here
}
