var keystone = require('keystone');

exports = module.exports = function(req, res) {

	var view = new keystone.View(req, res);
	var locals = res.locals;

	// Set locals
	locals.section = 'portfolio';
	locals.filters = {
		project: req.params.project
	};
	locals.data = {
		projects: []
	};

	// Load the current post
	view.on('init', function(next) {

		var q = keystone.list('Project').model.findOne({
			state: 'published',
			slug: locals.filters.project
		}).populate('author tags');

		q.exec(function(err, result) {
			locals.data.project = result;
			next(err);
		});

	});

	// Load other posts
	view.on('init', function(next) {

		var q = keystone.list('Project').model.find().where('state', 'published').sort('-publishedDate').populate('author').limit('4');

		q.exec(function(err, results) {
			locals.data.projects = results;
			next(err);
		});

	});

	// Render the view
	view.render('project');

};
