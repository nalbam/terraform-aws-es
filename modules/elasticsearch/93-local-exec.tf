# aws auth

resource "null_resource" "register_repo" {
  depends_on = [aws_elasticsearch_domain.this]

  provisioner "local-exec" {
    working_dir = path.module

    command = <<EOS
for i in `seq 1 5`; do \
  echo "${null_resource.register_repo.triggers.register_repo}" > register_repo.py & \
  python register_repo.py && break || \
  sleep 10; \
done; \
rm register_repo.py;
EOS


    interpreter = var.local_exec_interpreter
  }

  triggers = {
    register_repo = data.template_file.register_repo.rendered
    endpoint      = aws_elasticsearch_domain.this.endpoint
  }
}
