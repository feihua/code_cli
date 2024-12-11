use rust_embed::Embed;
use tera::{Context, Tera};

#[derive(Embed)]
#[folder = "templates/"]
struct Asset;

// 打印控制台和输出文件
pub fn write_file(mut tera: Tera, context: &mut Context, template_file_name: &str, target_file_name: &str) {
    let template_file = Asset::get(template_file_name).unwrap();
    let template_file_str =std::str::from_utf8(template_file.data.as_ref());

    let result = tera.render_str(template_file_str.unwrap(), &context);
    let r = result.unwrap();
    println!("{}", r);

    let cwd = std::env::current_dir().unwrap();
    let folder = cwd.as_path().join("generate").join(target_file_name);
    let path = folder.parent().unwrap();
    std::fs::create_dir_all(path).unwrap();
    println!("create -------------->{:?}", folder);

    let mut file = std::fs::File::create(folder).unwrap();
    std::io::Write::write_all(&mut file, r.as_ref()).unwrap();
}