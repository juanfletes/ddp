require 'test_helper'

class PersonasNotaSeguimientoControllerTest < ActionDispatch::IntegrationTest
  setup do
    @persona_nota_seguimiento = personas_nota_seguimiento(:one)
  end

  test "should get index" do
    get personas_nota_seguimiento_url
    assert_response :success
  end

  test "should get new" do
    get new_persona_nota_seguimiento_url
    assert_response :success
  end

  test "should create persona_nota_seguimiento" do
    assert_difference('PersonaNotaSeguimiento.count') do
      post personas_nota_seguimiento_url, params: { persona_nota_seguimiento: { fecha: @persona_nota_seguimiento.fecha, notas: @persona_nota_seguimiento.notas } }
    end

    assert_redirected_to persona_nota_seguimiento_url(PersonaNotaSeguimiento.last)
  end

  test "should show persona_nota_seguimiento" do
    get persona_nota_seguimiento_url(@persona_nota_seguimiento)
    assert_response :success
  end

  test "should get edit" do
    get edit_persona_nota_seguimiento_url(@persona_nota_seguimiento)
    assert_response :success
  end

  test "should update persona_nota_seguimiento" do
    patch persona_nota_seguimiento_url(@persona_nota_seguimiento), params: { persona_nota_seguimiento: { fecha: @persona_nota_seguimiento.fecha, notas: @persona_nota_seguimiento.notas } }
    assert_redirected_to persona_nota_seguimiento_url(@persona_nota_seguimiento)
  end

  test "should destroy persona_nota_seguimiento" do
    assert_difference('PersonaNotaSeguimiento.count', -1) do
      delete persona_nota_seguimiento_url(@persona_nota_seguimiento)
    end

    assert_redirected_to personas_nota_seguimiento_url
  end
end
