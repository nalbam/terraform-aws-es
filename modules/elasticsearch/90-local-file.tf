# local file

resource "local_file" "register_repo" {
  content  = "${data.template_file.register_repo.rendered}"
  filename = "${path.cwd}/.output/register_repo.py"
}

resource "local_file" "take_snapshot" {
  content  = "${data.template_file.take_snapshot.rendered}"
  filename = "${path.cwd}/.output/take_snapshot.py"
}

resource "local_file" "restore_snapshot_all" {
  content  = "${data.template_file.restore_snapshot_all.rendered}"
  filename = "${path.cwd}/.output/restore_snapshot_all.py"
}

resource "local_file" "restore_snapshot_one" {
  content  = "${data.template_file.restore_snapshot_one.rendered}"
  filename = "${path.cwd}/.output/restore_snapshot_one.py"
}
