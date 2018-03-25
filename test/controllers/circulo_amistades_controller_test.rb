require 'test_helper'

class CirculoAmistadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @circulo_amistad = circulo_amistades(:one)
  end

  test "should get index" do
    get circulo_amistades_url
    assert_response :success
  end

  test "should get new" do
    get new_circulo_amistad_url
    assert_response :success
  end

  test "should create circulo_amistad" do
    assert_difference('CirculoAmistad.count') do
      post circulo_amistades_url, params: { circulo_amistad: { direccion: @circulo_amistad.direccion, horario: @circulo_amistad.horario, nombre: @circulo_amistad.nombre, pasivo: @circulo_amistad.pasivo } }
    end

    assert_redirected_to circulo_amistad_url(CirculoAmistad.last)
  end

  test "should show circulo_amistad" do
    get circulo_amistad_url(@circulo_amistad)
    assert_response :success
  end

  test "should get edit" do
    get edit_circulo_amistad_url(@circulo_amistad)
    assert_response :success
  end

  test "should update circulo_amistad" do
    patch circulo_amistad_url(@circulo_amistad), params: { circulo_amistad: { direccion: @circulo_amistad.direccion, horario: @circulo_amistad.horario, nombre: @circulo_amistad.nombre, pasivo: @circulo_amistad.pasivo } }
    assert_redirected_to circulo_amistad_url(@circulo_amistad)
  end

  test "should destroy circulo_amistad" do
    assert_difference('CirculoAmistad.count', -1) do
      delete circulo_amistad_url(@circulo_amistad)
    end

    assert_redirected_to circulo_amistades_url
  end
end
