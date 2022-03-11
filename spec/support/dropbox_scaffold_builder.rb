# frozen_string_literal: true
# This class is useful to set up an existing Dropbox account in a state which
# is ready to pass the tests.
#
# For example, on the tests for the `delete` endpoint you may be deleting the
# file at `/delete/file.txt`, so we need to upload a file at that location or
# the test won't pass. That's exactly what {DropboxScaffoldBuilder#delete} is
# expected to do.
#
# Other endpoints' tests will have different requirements and this class is to
# provide an automated way to fulfill these. For each endpoint we need to test,
# you may have a method here that sets up everything that the tests for that
# endpoint needs.
#
# Note that, paradoxically, the methods here use the same methods we want to
# test. This shouldn't be a problem as the purpose of this is to allow us to
# regenerate the VCR cassettes, so if this automated mechanism fails you can
# always do the job manually and record the VCR cassette without using this.
#
# The Dropbox server may introduce minor changes over time so it's good to
# regenerate the cassettes every now and then, but we don't need to do it in
# every execution of the test suite.
class DropboxScaffoldBuilder
  def self.regenerate_all
    public_instance_methods
      .map(&:to_s)
      .select { |method_name| method_name.start_with?('build') }
      .each { |method_name| regenerate(method_name.sub('build_', '')) }
  end

  def self.regenerate(endpoint_name)
    builder = new(endpoint_name)
    builder.clobber
    builder.generate
  end

  def self.prefix_for(endpoint_name)
    new(endpoint_name).path_prefix
  end

  def self.fixtures_path
    File.expand_path('../../fixtures', __FILE__)
  end

  PREFIX = '/dropbox_api_fixtures'

  def initialize(endpoint_name)
    @endpoint_name = endpoint_name.to_s
  end

  def clobber
    client.delete path_prefix
  rescue DropboxApi::Errors::NotFoundError
    false # It's ok if it doesn't exist
  end

  def generate
    send "build_#{@endpoint_name}"
  end

  def client
    @client ||= DropboxApi::Client.new
  end

  def build_copy_batch
    client.upload("#{path_prefix}/regular_file.txt", 'Che primo! aon vas?')
    client.upload("#{path_prefix}/regular_file_2.txt", 'Pal Calvari, amic')
  end

  def build_create_file_request
    client.upload("#{path_prefix}/regular_file.txt", 'Arkansas, dude.')
  end

  def build_delete
    file_contents = 'Tijuana, amigo.'

    client.upload "#{path_prefix}/will_be_deleted.txt", file_contents
    client.upload "#{path_prefix}/wont_be_deleted.txt", file_contents
    client.upload "#{path_prefix}/folder/a.txt", file_contents
    client.upload "#{path_prefix}/folder/b.txt", file_contents
  end

  def build_get_metadata
    client.upload("#{path_prefix}/file.txt", 'This is a test file.', {
      client_modified: Time.new(1988, 12, 8, 1, 1, 0, '+00:00')
    })
    client.create_folder("#{path_prefix}/folder")
    client.upload("#{path_prefix}/deleted_file.txt", 'This is a test file.')
    client.delete("#{path_prefix}/deleted_file.txt")
  end

  def build_list_folder
    client.create_folder("#{path_prefix}/shared_folder")
    client.create_shared_link_with_settings("#{path_prefix}/shared_folder")
    client.upload("#{path_prefix}/shared_folder/cow.txt", 'Moo.')
  end

  def build_list_folder_longpoll
    client.create_folder("#{path_prefix}")
  end

  def build_upload
    # No need to set up anything
  end

  def build_upload_by_chunks
    # No op
  end

  def build_get_thumbnail_batch
    file_content = IO.read File.join(self.class.fixtures_path, 'img.png')
    client.upload("#{path_prefix}/img.png", file_content)
  end

  def build_get_shared_link_metadata
    client.create_folder("#{path_prefix}/shared_folder")
    client.create_shared_link_with_settings("#{path_prefix}/shared_folder")

    client.upload("#{path_prefix}/shared_file.txt", 'I shall be shared.')
    client.create_shared_link_with_settings("#{path_prefix}/shared_file.txt")
  end

  def build_search
    client.upload("#{path_prefix}/findable_file.txt", 'Moo.')
  end

  # We have a prefix for each endpoint to avoid conflicts across them
  def path_prefix
    File.join PREFIX, @endpoint_name
  end
end
