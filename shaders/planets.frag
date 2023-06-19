uniform vec4 diffuse = vec4(0.0, 1, 0, 1);
uniform float shine = 128;
uniform vec4 specular = vec4(0.5, 0.5, 1.0, 1.0);
uniform sampler2D grass;

in Data{
    vec4 pos;
    vec4 old_pos;
    vec3 n;
    vec3 l_dir;
    vec4 eye;
} DataIn;

out vec4 color;

void main(){
    vec3 n = normalize(DataIn.n);
    vec3 l = normalize(DataIn.l_dir);
    vec3 e = vec3(normalize(DataIn.eye));

    float intensity = max(dot(n,l), 0.0);
    vec4 spec = vec4(0);
    vec4 d = texture(grass, vec2(DataIn.pos.x,DataIn.pos.y));


    float newdist = sqrt(
        DataIn.pos.x * DataIn.pos.x +
        DataIn.pos.y * DataIn.pos.y +
        DataIn.pos.z * DataIn.pos.z
    );
    float olddist = sqrt(
        DataIn.old_pos.x * DataIn.old_pos.x +
        DataIn.old_pos.y * DataIn.old_pos.y +
        DataIn.old_pos.z * DataIn.old_pos.z
    );
    float is_spec = 0;
    if (newdist - olddist <= 0) {
        d = vec4(0.0, 0, 1, 1);
        is_spec = 1;
    }
        
    if (intensity > 0){
        vec3 h = normalize(DataIn.l_dir + e);
        
        float intSpec = max(dot(h,n), 0.0);

        spec = is_spec * specular * pow(intSpec, shine);
    }

    color = (max(intensity, 0.25) * d) + spec;
}
