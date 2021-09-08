let project = new Project('Live Preview');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');
project.addLibrary('twinspire');
project.addLibrary('hxnodejs');

resolve(project);
