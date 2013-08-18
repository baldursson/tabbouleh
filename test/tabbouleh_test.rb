require 'test_helper'

class TabboulehTest < ActionController::TestCase
  tests ContactsController

  test 'field with presence validator should have data-required attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_name"]' do
      assert_select '[data-required=?]', 'true'
    end
  end

  test 'field with custom error message should have data-error-message attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_name"]' do
      assert_select '[data-required-message=?]', CGI::escapeHTML("Name was not entered")
    end
  end

  test 'checkbox with acceptance validation should have data-required attribute' do
    get :new
    assert_select 'input[type="checkbox"][id="contact_terms"]' do
      assert_select '[data-required=?]', 'true'
    end
  end

  test 'confirmation field should have data-equalto attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_email_confirmation"]' do
      assert_select '[data-equalto=?]', '#contact_email'
    end
  end

  test 'field with format validator should have data-regexp attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_email"]' do
      assert_select '[data-regexp=?]', '^[^@]+@([^@\.]+\.)+[^@\.]+$'
    end
  end

  test 'field with minimum length validator should have data-minlength attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_name"]' do
      assert_select '[data-minlength=?]', '8'
    end
  end

  test 'field with maximum length validator should have data-maxlength attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_name"]' do
      assert_select '[data-maxlength=?]', '50'
    end
  end

  test 'field with length rage validator should have data-minlength and data-maxlength attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_phone_number"]' do
      assert_select '[data-minlength=?]', '7'
      assert_select '[data-maxlength=?]', '12'
    end
  end

  test 'field with exact length validator should have data-rangelength attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_zip_code"]' do
      assert_select '[data-rangelength=?]', '5'
    end
  end

  test 'field with numericality validator should have data-type="number" attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_phone_number"]' do
      assert_select '[data-type=?]', 'number'
    end
  end

  test 'field with numericality validator with "only_integer" option should have data-type="digits" attribute' do
    get :new
    assert_select 'input[type="text"][id="contact_zip_code"]' do
      assert_select '[data-type=?]', 'digits'
    end
  end

  test 'field with numericality validator with "greater_than" option should have data-min attribute' do
    get :new
    assert_select 'input[id="contact_human_test_one"]' do
      assert_select '[data-min=?]', '11'
    end
  end

  test 'field with numericality validator with "greater_than_or_equal_to" option should have data-min attribute' do
    get :new
    assert_select 'select[id="contact_age"]' do
      assert_select '[data-min=?]', '18'
    end
  end

  test 'field with numericality validator with "less_than" option should have data-max attribute' do
    get :new
    assert_select 'input[id="contact_human_test_one"]' do
      assert_select '[data-max=?]', '19'
    end
  end

  test 'field with numericality validator with "less_than_or_equal_to" option should have data-max attribute' do
    get :new
    assert_select 'input[id="contact_human_test_two"]' do
      assert_select '[data-max=?]', '30'
    end
  end

  # test 'field with numericality validator with "equal_to" option should have data-min attribute' do
  #   get :new
  #   assert_select 'input[id="contact_human_test_one"]' do
  #     assert_select '[data-min=?]', '10'
  #   end
  # end
end