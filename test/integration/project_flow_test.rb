require 'test_helper'

class ProjectFlowTest < ActionDispatch::IntegrationTest
  fixtures :projects

  test 'can read a project' do
    project_one = projects(:one)

    get '/'
    assert_response :success
    assert_select 'a[href=?]', projects_path

    get projects_path
    assert_response :success
    assert_select 'a[href=?]', project_path(project_one)

    get project_path(project_one)
    assert_response :success
    assert_select 'h1', project_one.title
    assert_select 'p:contains(?)', project_one.content.truncate(20, omission: '')
  end
end
