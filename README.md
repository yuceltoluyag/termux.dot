# Termux Installation Script

Bu betik, Termux üzerinde çeşitli yazılımların otomatik olarak yüklenmesi ve yapılandırılması için hazırlanmıştır. Aşağıda desteklenen yazılımlar ve kullanım talimatları bulunmaktadır.

## Desteklenen Yazılımlar

- **Elixir**
- **Golang**
- **Python**
- **Neovim** (NvChad ile birlikte)
- **Node.js (LTS)**
- **Tmux**
- **Ruby**
- **PHP**
- **Zsh** (Oh-My-Zsh ile birlikte)
- **Clang ve Geliştirme Araçları**
- **Çeşitli araçlar**: curl, wget, git, vim, nano, ffmpeg, imagemagick, zip, unzip, cmatrix, figlet, cowsay, toilet, lolcat, ve daha fazlası.

## Kurulum

Bu betiği çalıştırmak için önce Termux uygulamasını yükleyin ve ardından aşağıdaki adımları takip edin:

### 1. Betiği klonlayın veya indirin

```bash
git clone https://github.com/yuceltoluyag/termux.dot.git
cd termux-termux.dot
```

### 2. Betiği çalıştırma izni verin

```bash
chmod +x install.sh
```

### 3. Betiği çalıştırın

Kurmak istediğiniz yazılımlara göre aşağıdaki komutlardan birini çalıştırabilirsiniz.

#### Tüm yazılımları yüklemek için

```bash
./install.sh --all
```

#### Belirli yazılımları yüklemek için

| Yazılım | Komut                   |
| ------- | ----------------------- |
| Elixir  | `./install.sh --elixir` |
| Go      | `./install.sh --golang` |
| Python  | `./install.sh --python` |
| Neovim  | `./install.sh --nvim`   |
| Node.js | `./install.sh --nodejs` |
| Tmux    | `./install.sh --tmux`   |
| Ruby    | `./install.sh --ruby`   |
| PHP     | `./install.sh --php`    |
| Zsh     | `./install.sh --zsh`    |

### 4. Termux'u yeniden başlatma

Zsh gibi kabuk değişiklikleri veya bazı yazılım yapılandırmaları için Termux'u yeniden başlatmanız gerekebilir. Zsh yüklendikten sonra aşağıdaki komutla Termux'u yeniden başlatabilirsiniz:

```bash
exit
```

## Gerekli Bağımlılıklar

Bu betik aşağıdaki bağımlılıkları kontrol eder ve eksik olanları yükler:

- `git`
- `curl`
- `wget`
- `nano`
- `vim`
- `zip`
- `unzip`
- `nmap`
- `openssh`
- `tmux`
- `ffmpeg`
- `imagemagick`
- `clang`
- `libcrypt-dev`
- `binutils`
- `pkg-config`
- `python3`
- `cmatrix`
- `figlet`
- `cowsay`
- `toilet`
- `lolcat`
- `net-tools`
- `w3m`

## Özelleştirme

Betikteki yazılımların yüklenmesini özelleştirmek için `install.sh` dosyasını düzenleyebilirsiniz. İhtiyacınız olmayan yazılımların yüklenmesini engellemek için ilgili `install_` fonksiyonlarını kaldırabilir veya değiştirebilirsiniz.

## Katkıda Bulunma

Katkıda bulunmak isterseniz, bu projeyi fork'layıp kendi geliştirmelerinizi yapabilir ve pull request oluşturabilirsiniz. Hatalar veya öneriler için issue açabilirsiniz.

## Lisans

Bu proje MIT Lisansı ile lisanslanmıştır. Daha fazla bilgi için `LICENSE` dosyasına bakın.

```


```
