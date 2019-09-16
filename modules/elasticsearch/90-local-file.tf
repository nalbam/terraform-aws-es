# local file

resource "local_file" "register_repo" {
  content  = data.template_file.register_repo.rendered
  filename = "${path.cwd}/.output/register_repo.py"
}
