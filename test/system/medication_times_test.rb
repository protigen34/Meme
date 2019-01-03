require "application_system_test_case"

class MedicationTimesTest < ApplicationSystemTestCase
  setup do
    @medication_time = medication_times(:one)
  end

  test "visiting the index" do
    visit medication_times_url
    assert_selector "h1", text: "Medication Times"
  end

  test "creating a Medication time" do
    visit medication_times_url
    click_on "New Medication Time"

    click_on "Create Medication time"

    assert_text "Medication time was successfully created"
    click_on "Back"
  end

  test "updating a Medication time" do
    visit medication_times_url
    click_on "Edit", match: :first

    click_on "Update Medication time"

    assert_text "Medication time was successfully updated"
    click_on "Back"
  end

  test "destroying a Medication time" do
    visit medication_times_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Medication time was successfully destroyed"
  end
end
