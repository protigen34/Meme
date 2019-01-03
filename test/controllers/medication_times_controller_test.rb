require 'test_helper'

class MedicationTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @medication_time = medication_times(:one)
  end

  test "should get index" do
    get medication_times_url
    assert_response :success
  end

  test "should get new" do
    get new_medication_time_url
    assert_response :success
  end

  test "should create medication_time" do
    assert_difference('MedicationTime.count') do
      post medication_times_url, params: { medication_time: {  } }
    end

    assert_redirected_to medication_time_url(MedicationTime.last)
  end

  test "should show medication_time" do
    get medication_time_url(@medication_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_medication_time_url(@medication_time)
    assert_response :success
  end

  test "should update medication_time" do
    patch medication_time_url(@medication_time), params: { medication_time: {  } }
    assert_redirected_to medication_time_url(@medication_time)
  end

  test "should destroy medication_time" do
    assert_difference('MedicationTime.count', -1) do
      delete medication_time_url(@medication_time)
    end

    assert_redirected_to medication_times_url
  end
end
