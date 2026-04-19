-- tabela de snippets
local snippets = {
  git = {
    status = "git status",
    add = "git add",
    add_all = "git add .",
    commit = "git commit -m ",
    amend = "git commit --amend --no-edit",
    push = "git push origin main",
    force_push = "git push origin main --force",
    pull = "git pull origin main",
    clone = "git clone",
    remote_add = "git remote add origin",
    fetch = "git fetch",
    log = "git log --oneline --graph --decorate",
    branch = "git branch",
    checkout = "git checkout ",
    new_branch = "git checkout -b ",
    merge = "git merge ",
    stash = "git stash",
    stash_pop = "git stash pop",
    reset_soft = "git reset --soft HEAD~1",
    reset_hard = "git reset --hard HEAD",
    clean = "git clean -fd",
    init = "git init",
    config_name = "git config --global user.name ",
    config_email = "git config --global user.email ",
    url_set = "git remote set-url origin"
  },

  mvn = {
    clean_install = "mvn clean install",
    install = "mvn install",
    clean = "mvn clean",
    clean_compile = "mvn clean compile",
    run = "mvn spring-boot:run",
    compile = "mvn compile",
    test = "mvn test",
    test_single = "mvn test -Dtest=",
    package = "mvn package",
    package_no_test = "mvn package -DskipTests",
    dependency_tree = "mvn dependency:tree",
    dependency_analyze = "mvn dependency:analyze",
    version = "mvn -version"
  },

  argos = {
    update = "argospm update",
    translate_en_pt = "/home/vinisskt/.venvs/argos/bin/argos-translate --from-lang en --to-lang pt"
  },

  docker = {
    ps = "docker ps",
    ps_all = "docker ps -a",
    images = "docker images",
    up = "docker-compose up -d",
    down = "docker-compose down",
    stop_all = "docker stop $(docker ps -q)",
    clean_images = "docker image prune -f",
    clean_volumes = "docker volume prune -f",
    logs = "docker logs -f "
  },

  pacman = {
    install = "sudo pacman -S ",
    remove = "sudo pacman -Rs ",
    update = "yay -Syu",
    search = "pacman -Ss ",
    clean = "sudo pacman -Sc",
    list_explicit = "pacman -Qqe",
    orphans = "pacman -Qtdq"
  },

  hypr = {
    reload = "hyprctl reload",
    picker = "hyprpicker -a",
    kill = "hyprctl kill",
    clients = "hyprctl clients",
    monitors = "hyprctl monitors"
  },

  db = {
    pg_start = "sudo systemctl start postgresql",
    pg_stop = "sudo systemctl stop postgresql",
    pg_status = "sudo systemctl status postgresql",
    my_start = "sudo systemctl start mariadb",
    my_stop = "sudo systemctl stop mariadb",
    my_status = "sudo systemctl status mariadb"
  },

  utils = {
    ls = "eza --icons",
    ll = "eza -l --icons",
    la = "eza -a --icons",
    lt = "eza --tree --icons",
    cat = "bat ",
    help = "tldr ",
    find = "fd ",
    search = "rg "
  }
}


return snippets
