{% extends "../layouts/default.swig" %}

{% macro showPost(post) %}
	<div class="post" data-ks-editable="editable(user, { list: 'Project', id: post.id })">
		<h2>
			<a href="/portfolio/project/{{ post.slug }}">{{ post.title }}</a>
		</h2>
		<p class="lead text-muted">Posted
			{% if post.publishedDate %}
				<br>on {{ post._.publishedDate.format("MMMM Do, YYYY") }}
			{% endif %}
			{% if post.tags and post.tags.length %}
				<br>in
				{% for cat in post.tags %}
					<a href="/blog/{{ cat.key }}">{{ cat.name }}</a>
					{% if loop.index < post.tags.length - 1 %}, {% endif %}
				{% endfor %}
			{% endif %}
			{% if post.author %}
				<br>by {{ post.author.name.first }}
			{% endif %}
		</p>
		{% if post.image.exists %}
			<img src="{{ post._.image.fit(160,160) }}" class="img pull-right">
		{% endif %}
		<p>{{ post.content.brief | safe }}</p>
		{% if post.content.extended %}
			<p class="read-more">
				<a href="/portfolio/project/{{ post.slug }}">Read more...</a>
			</p>
		{% endif %}
	</div>
{% endmacro %}

{% block intro %}
	<div class="container">
		{% set title = "Portfolio" %}
		{% if data.category %}
			{% set title = data.tag.name %}
		{% endif %}
		<h1>{{ title }}</h1>
	</div>
{% endblock %}

{% block content %}
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				{% if filters.tag and not data.tag %}
					<h3 class="text-muted">Invalid Tag.</h3>
				{% else %}
					{% if data.projects.results.length %}
						{% if data.posts.totalPages > 1 %}
							<h4 class="text-weight-normal">Showing
								<strong>{{ data.projects.first }}</strong>
								to
								<strong>{{ data.projects.last }}</strong>
								of
								<strong>{{ data.projects.total }}</strong>
								posts.
							</h4>
						{% else %}
							<h4 class="text-weight-normal">Showing {{ utils.plural(data.projects.results.length, "* post") }}.</h4>
						{% endif %}
						<div class="blog">
							{% for project in data.projects.results %}
								{{ showPost(project) }}
							{% endfor %}
						</div>
						{% if data.projects.totalPages > 1 %}
							<ul class="pagination">
								{% if data.projects.previous %}
									<li>
										<a href="?page={{ data.projects.previous }}">
											<span class="glyphicon glyphicon-chevron-left"></span>
										</a>
									</li>
								{% else %}
									<li class="disabled">
										<a href="?page=1">
											<span class="glyphicon glyphicon-chevron-left"></span>
										</a>
									</li>
                                                                {% endif %}
									{% for p in data.projects.pages %}
										<li class="{% if data.projects.currentPage == p %}active{% endif %}">
											<a href="?page={% if p == "..." %}{% if i %}{{ data.projects.totalPages }}{% else %}1{% endif %}{% else %}{{ p }}{% endif %}">{{ p }}</a>
										</li>
									{% endfor %}
								{% if data.projects.next %}
									<li>
										<a href="?page={{ data.projects.next }}">
											<span class="glyphicon glyphicon-chevron-right"></span>
										</a>
									</li>
								{% else %}
									<li class="disabled">
										<a href="?page={{ data.projects.totalPages }}">
											<span class="glyphicon glyphicon-chevron-right"></span>
										</a>
									</li>
								{% endif %}
							</ul>
						{% endif %}
					{% else %}
						{% if data.tag %}
							<h3 class="text-muted">There are no projects in the category {{ data.tag.name }}.</h3>
						{% else %}
							<h3 class="text-muted">There are no projects yet.</h3>
						{% endif %}
					{% endif %}
				{% endif %}
			</div>
			{% if data.tags.length %}
			<div class="col-sm-4 col-md-3">
				<h2>Tags</h2>
				<div class="list-group" style="margin-top: 70px;">
					<a href="/portfolio" class="{% if not data.tag %}active{% endif %} list-group-item">All Tags</a>
					{% for cat in data.categories %}
						<a href="/portfolio/{{ cat.key }}" class="{% if data.tag and data.tag.id == cat.id %}active{% endif %} list-group-item">{{ cat.name }}</a>
					{% endfor %}
				</div>
			</div>
			{% endif %}
		</div>
	</div>
{% endblock %}
