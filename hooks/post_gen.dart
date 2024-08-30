import 'dart:io';

import 'package:mason/mason.dart';

import 'constants.dart';
import 'gitlab.dart';

void run(HookContext context) async {
  final gitlabConfiguration = File.fromUri(
    Directory.current.absolute.parent.parent.uri.resolve(kGitlabFileName),
  );

  final hasGitlabConfiguration = gitlabConfiguration.existsSync();

  final hasPipelineContext = hasGitlabConfiguration;
  if (!hasPipelineContext) {
    context.logger.err(
      'a CD/CI configuration was not found, if you want to add it in the future you will have to configure the deployment manually. Visit the documentation https://clidocs-devmy-pillars-projects.vercel.app/commands/generate/addon/firebase_deploy',
    );

    return;
  }

  final String applicationName = context.vars[kApplicationNameKey] as String;
  if (hasGitlabConfiguration) {
    updateGitlabCdCi(gitlabConfiguration, applicationName);
  }
}
