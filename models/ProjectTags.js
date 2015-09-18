var keystone = require('keystone');

/**
 * ProjectTags Model
 * ==================
 */

var ProjectTags = new keystone.List('ProjectTags', {
	autokey: { from: 'name', path: 'key', unique: true }
});

ProjectTags.add({
	name: { type: String, required: true }
});

ProjectTags.relationship({ ref: 'Project', path: 'tags' });

ProjectTags.register();
