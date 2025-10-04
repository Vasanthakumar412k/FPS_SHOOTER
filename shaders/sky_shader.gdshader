shader_type sky;

uniform vec3 top_sky : source_color = vec3(0, 0, 0.2);
uniform vec3 bottom_sky : source_color = vec3(0, 0, 0.3);
uniform vec3 sun_color : source_color = vec3(0.1, 0.1, 0.1);
uniform vec3 sun_ray_color : source_color = vec3(0.2, 0.2, 0.2);
uniform float sun_disk_size : hint_range(0.8, 1.0) = 0.995;
uniform float sun_ray_size : hint_range(0.8, 1.0) = 0.9;
uniform vec3 sun_scatter : source_color = vec3(0.2, 0, 0);

// 🌥️ Cloud parameters
uniform sampler2D cloud_shape_sampler : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D cloud_noise_sampler : filter_linear_mipmap_anisotropic, repeat_enable;
uniform float cloud_density : hint_range(0.0, 100.0) = 0.5;
uniform float cloud_speed = 0.01;
uniform vec3 cloud_color : source_color = vec3(1.0);

float get_cloud(vec2 uv) {
    vec2 move = vec2(TIME * cloud_speed, 0.0);
    float shape = texture(cloud_shape_sampler, uv + move).r;
    float noise = texture(cloud_noise_sampler, uv * 2.0 - move * 0.5).r;
    float density = shape * noise;
    return smoothstep(0.5, 1.0, density) * cloud_density;
}

void sky() {
    float horizon_mask = abs(EYEDIR.y);
    vec3 sky_color = mix(bottom_sky, top_sky, horizon_mask);

    // ☀️ Sun calculations
    vec3 eye_dir = normalize(EYEDIR);
    vec3 sun_dir = normalize(LIGHT0_DIRECTION);
    float look = dot(eye_dir, sun_dir);
    float sun_disk = smoothstep(sun_disk_size, 1.0, look);
    float sun_disk_ray = smoothstep(sun_ray_size, 1.0, look) - sun_disk;
    vec3 scatter = sun_scatter * (1.0 - horizon_mask);

    // 🌥️ Clouds
    vec2 cloud_uv = (eye_dir.xz / clamp(eye_dir.y, 0.1, 1.0)) * 0.2 + vec2(0.5);
    float cloud_mask = get_cloud(cloud_uv);
    sky_color = mix(sky_color, cloud_color, cloud_mask * horizon_mask);

    COLOR = sun_disk * sun_color +
            sun_disk_ray * sun_ray_color+sky_color;
}
