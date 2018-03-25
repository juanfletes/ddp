require 'test_helper'

class MatrimoniosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @matrimonio = matrimonios(:one)
  end

  test "should get index" do
    get matrimonios_url
    assert_response :success
  end

  test "should get new" do
    get new_matrimonio_url
    assert_response :success
  end

  test "should create matrimonio" do
    assert_difference('Matrimonio.count') do
      post matrimonios_url, params: { matrimonio: { boda_civil: @matrimonio.boda_civil, boda_eclesiastica: @matrimonio.boda_eclesiastica, ddp: @matrimonio.ddp, esposa_id: @matrimonio.esposa_id, esposo_id: @matrimonio.esposo_id, fecha_civil: @matrimonio.fecha_civil, fecha_elesiastica: @matrimonio.fecha_elesiastica, observacion: @matrimonio.observacion } }
    end

    assert_redirected_to matrimonio_url(Matrimonio.last)
  end

  test "should show matrimonio" do
    get matrimonio_url(@matrimonio)
    assert_response :success
  end

  test "should get edit" do
    get edit_matrimonio_url(@matrimonio)
    assert_response :success
  end

  test "should update matrimonio" do
    patch matrimonio_url(@matrimonio), params: { matrimonio: { boda_civil: @matrimonio.boda_civil, boda_eclesiastica: @matrimonio.boda_eclesiastica, ddp: @matrimonio.ddp, esposa_id: @matrimonio.esposa_id, esposo_id: @matrimonio.esposo_id, fecha_civil: @matrimonio.fecha_civil, fecha_elesiastica: @matrimonio.fecha_elesiastica, observacion: @matrimonio.observacion } }
    assert_redirected_to matrimonio_url(@matrimonio)
  end

  test "should destroy matrimonio" do
    assert_difference('Matrimonio.count', -1) do
      delete matrimonio_url(@matrimonio)
    end

    assert_redirected_to matrimonios_url
  end
end
