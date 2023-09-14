output "build_id" {
    value = "${aws_codebuild_project.build.id}"
}

output "pipeline_id" {
    value = "${aws_codepipeline.pipeline.id}"
}