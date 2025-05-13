# Installed by:
# version = "0.104.0"
#
# See https://www.nushell.sh/book/configuration.html
# See `help config nu` for more options
# See `config nu` for editing this file
# See the artifact https://claude.ai/public/artifacts/5b5730f7-5e24-4614-a02d-6f24ad582818

# --------------------------
# ENVIRONMENT CONFIGURATION
# --------------------------

# Add common development tool paths
$env.PATH = ($env.PATH | split row (char esep) | 
    append [
        "C:\\Program Files\\nodejs"
        "C:\\Users\\$env.USER\\.yarn\\bin"
        "C:\\Users\\$env.USER\\AppData\\Roaming\\npm"
        "C:\\Program Files\\Git\\bin"
        "C:\\Program Files\\Git\\usr\\bin"
    ] | uniq)

# Set default editor (use your preferred editor)
$env.EDITOR = "code"

# Remove Welcome Messages
$env.config.show_banner = false

# Set Node.js environment
$env.NODE_ENV = "development"
$env.NODE_OPTIONS = "--max-old-space-size=4096" # Increase memory for larger projects

# --------------------------
# PROMPT CUSTOMIZATION
# --------------------------

def create_left_prompt [] {
    let dir_segment = if (is-admin) {
        $"(ansi red_bold)($env.PWD)(ansi reset)"
    } else {
        $"(ansi green_bold)($env.PWD | path basename)(ansi reset)"
    }
    
    let git_segment = if (do { git rev-parse --is-inside-work-tree } | complete | get exit_code) == 0 {
        let branch = do { git branch --show-current } | str trim
        let status = do { git status --porcelain | lines | length }
        if $status == 0 {
            $"(ansi blue_bold)❰($branch)❱(ansi reset)"
        } else {
            $"(ansi yellow_bold)❰($branch)*❱(ansi reset)"
        }
    } else {
        ""
    }
    
    let node_segment = if (exists package.json) {
        let version = do { node --version } | str trim
        $"(ansi cyan_bold)⬢ ($version)(ansi reset)"
    } else {
        ""
    }
    
    $"($dir_segment) ($git_segment) ($node_segment)> "
}

$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { date now | date format '%H:%M:%S' }

# --------------------------
# ALIASES & SHORTCUTS
# --------------------------

# File Navigation & System
alias ll = ls -la
alias la = ls -a
alias l = ls
alias cls = clear
alias .. = cd ..
alias ... = cd ../..
alias md = mkdir
alias rd = rmdir
alias home = cd ~

# Git Shortcuts
alias gs = git status
alias gl = git log --oneline --graph --decorate --all -10
alias gp = git pull
alias gpush = git push
alias gco = git checkout
alias gc = git commit -m
alias ga = git add
alias gd = git diff
alias gb = git branch
alias gr = git restore
alias grs = git restore --staged

# Front-end Development
alias ns = npm start
alias nt = npm test
alias ni = npm install
alias nid = npm install --save-dev
alias nr = npm run
alias dev = npm run dev
alias build = npm run build
alias serve = npm run serve
alias lint = npm run lint
alias ng = npm run generate

# Yarn (if you use it)
alias y = yarn
alias ys = yarn start
alias yd = yarn dev
alias ya = yarn add
alias yad = yarn add --dev
alias yb = yarn build
alias yt = yarn test

# Frontend Testing & Performance
alias lh = npx lighthouse
alias psi = npx psi
alias a11y = npx pa11y

# --------------------------
# CUSTOM FUNCTIONS
# --------------------------

# Create a new React component
def create-component [name: string, type: string = "functional"] {
    let component_folder = $"src/components/($name)"
    mkdir $component_folder
    
    # Create component file
    let component_content = if $type == "functional" {
        $"import React from 'react';
import './($name).css';

const ($name) = (props) => {
  return (
    <div className=\"($name|str downcase)\">
      {/* ($name) Component */}
    </div>
  );
};

export default ($name);"
    } else {
        $"import React, { Component } from 'react';
import './($name).css';

class ($name) extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return (
      <div className=\"($name|str downcase)\">
        {/* ($name) Component */}
      </div>
    );
  }
}

export default ($name);"
    }
    
    $component_content | save -f $"($component_folder)/($name).jsx"
    
    # Create CSS file
    $".($name|str downcase) {\n  /* Styles for ($name) */\n}" | save -f $"($component_folder)/($name).css"
    
    # Create index file for easy importing
    $"export { default } from './($name)';" | save -f $"($component_folder)/index.js"
    
    echo $"✅ Created ($type) component ($name) in ($component_folder)"
}

# Package.json analyzer
def analyze-pkg [] {
    if not (exists package.json) {
        echo "❌ No package.json found in current directory"
        return
    }
    
    let pkg = open package.json
    let deps_count = ($pkg | get dependencies | default {} | columns | length)
    let dev_deps_count = ($pkg | get devDependencies | default {} | columns | length)
    let scripts_count = ($pkg | get scripts | default {} | columns | length)
    
    echo $"📦 Package name: ($pkg.name) v($pkg.version)"
    echo $"📋 Description: ($pkg.description)"
    echo $"👨‍💻 Author: ($pkg.author)"
    echo $"📚 Dependencies: ($deps_count)"
    echo $"🔧 DevDependencies: ($dev_deps_count)"
    echo $"🛠️ Scripts: ($scripts_count)"
    
    echo "Available scripts:"
    $pkg | get scripts | default {} | columns | each { |script|
        echo $"  - ($script): npm run ($script)"
    }
}

# Project starter
def scaffold-project [name: string, type: string = "react"] {
    mkdir $name
    cd $name
    
    if $type == "react" {
        echo "⚛️ Creating React project..."
        npx create-react-app .
    } else if $type == "vue" {
        echo "🟢 Creating Vue project..."
        npm init vue@latest
    } else if $type == "next" {
        echo "▲ Creating Next.js project..."
        npx create-next-app .
    } else {
        echo "🚀 Creating vanilla JS project..."
        mkdir -p src public
        
        # Create package.json
        echo '{
  "name": "' + $name + '",
  "version": "1.0.0",
  "description": "Vanilla JS project",
  "main": "src/index.js",
  "scripts": {
    "start": "webpack serve --mode development",
    "build": "webpack --mode production",
    "test": "jest"
  }
}' | save -f package.json
        
        # Create index files
        echo '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>' + $name + '</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div id="app"></div>
  <script src="bundle.js"></script>
</body>
</html>' | save -f public/index.html
        
        echo "// Main application entry point
console.log('Application started');" | save -f src/index.js
        
        echo "/* Main stylesheet */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 20px;
}" | save -f public/style.css
    }
    
    echo $"✅ Created ($type) project: ($name)"
    echo "📁 Next steps:"
    echo "  1. Review the project structure"
    echo "  2. Install dependencies (npm install)"
    echo "  3. Start development server (npm start or npm run dev)"
}

# Data helper - Parse CSV
def csv-preview [file: path] {
    open $file | first 10
}

# Data helper - Parse JSON
def json-preview [file: path] {
    open $file | to yaml
}

# Performance analyzer for npm modules
def analyze-deps [] {
    echo "🔍 Analyzing dependencies size..."
    npm list --depth=0
    npx cost-of-modules --no-install
}

# Bundle size analyzer
def analyze-bundle [] {
    if not (exists package.json) {
        echo "❌ No package.json found in current directory"
        return
    }
    
    echo "📊 Analyzing bundle size..."
    npx source-map-explorer dist/**/*.js
}

# Find unused dependencies
def find-unused-deps [] {
    echo "🧹 Finding unused dependencies..."
    npx depcheck
}

# --------------------------
# COMPLETIONS
# --------------------------

# NPM completions
def "nu-complete npm-commands" [] {
    ["install", "uninstall", "run", "start", "test", "publish", "update"]
}

def "nu-complete npm-scripts" [] {
    if (exists package.json) {
        open package.json | get scripts | default {} | columns
    } else {
        []
    }
}

# Complete npm run with scripts from package.json
export extern "npm run" [
    script: string@"nu-complete npm-scripts" # Script name
    --workspace(-w): string                  # Run script in specified workspace
    --help(-h)                               # Help for specific command
]

# Git completions
def "nu-complete git-branches" [] {
    git branch | lines | each { |line| $line | str replace '\* ' '' | str trim }
}

# Complete git checkout with branch names
export extern "git checkout" [
    branch?: string@"nu-complete git-branches" # Branch name
    --help(-h)                                 # Help for specific command
]

# --------------------------
# STARTUP COMMANDS
# --------------------------

# Show a welcome message on startup
def show_welcome [] {
    let date_str = (date now | date format "%A, %B %d, %Y")
    print $"(ansi green_bold)Welcome to Nushell! Today is ($date_str)(ansi reset)"
    print $"(ansi yellow_bold)Frontend Engineer Edition(ansi reset)"
    print $"Type 'help-fe' for frontend-specific commands"
}

# Helper command to show frontend-specific commands
def help-fe [] {
    echo "🚀 Frontend-specific Nushell commands:"
    echo ""
    echo "Project Management:"
    echo "  scaffold-project <name> <type>  - Create a new project (react, vue, next, vanilla)"
    echo "  create-component <name> <type>  - Create a new React component"
    echo ""
    echo "Analysis:"
    echo "  analyze-pkg                     - Analyze package.json"
    echo "  analyze-deps                    - Analyze dependencies size"
    echo "  analyze-bundle                  - Analyze bundle size"
    echo "  find-unused-deps                - Find unused dependencies"
    echo ""
    echo "Data Helpers:"
    echo "  csv-preview <file>              - Preview CSV data"
    echo "  json-preview <file>             - Preview JSON data as YAML"
    echo ""
    echo "Common Aliases:"
    echo "  ns, nt, ni, nr                  - npm start, test, install, run"
    echo "  dev, build, serve               - npm run dev, build, serve"
    echo "  y, ys, ya, yt                   - yarn, yarn start, add, test"
}

# Run welcome message
show_welcome

# --------------------------
# KEY BINDINGS
# --------------------------

# Use emacs-style key bindings
$env.config = {
    keybindings: {
        normal: {
            j: { type: Move value: Left }
            k: { type: Move value: Down }
            l: { type: Move value: Up }
            ";": { type: Move value: Right }
        }
    }
}

# --------------------------
# THEME & APPEARANCE
# --------------------------

# Change colors to a coder-friendly dark theme
$env.config = {
    color_config: {
        separator: "#88C0D0"
        leading_trailing_space_bg: { attr: n }
        header: { fg: "#A3BE8C" attr: b }
        empty: "#81A1C1"
        bool: {|| if $in { "#A3BE8C" } else { "#BF616A" } }
        int: "#B48EAD"
        filesize: {|e|
            if $e == 0b { "#81A1C1" }
            else if $e < 1mb { "#A3BE8C" }
            else if $e < 10mb { "#EBCB8B" }
            else if $e < 100mb { "#D08770" }
            else { "#BF616A" }
        }
        duration: "#B48EAD"
        date: {|| (date now) - $in |
            if $in < 1hr { "#5E81AC" }
            else if $in < 1day { "#A3BE8C" }
            else if $in < 3day { "#EBCB8B" }
            else if $in < 1wk { "#D08770" }
            else if $in < 6wk { "#BF616A" }
            else { "#4C566A" }
        }
        range: "#B48EAD"
        float: "#B48EAD"
        string: "#A3BE8C"
        nothing: "#4C566A"
        binary: "#81A1C1"
        cell-path: "#88C0D0"
        row_index: { fg: "#88C0D0" attr: b }
        record: "#ECEFF4"
        list: "#ECEFF4"
        block: "#ECEFF4"
        hints: "#4C566A"
        search_result: { fg: "#BF616A" bg: "#2E3440" }
    }
    use_grid_icons: true
    footer_mode: "25"
    float_precision: 2
    buffer_editor: $env.EDITOR
    use_ansi_coloring: true
    edit_mode: emacs
    shell_integration: true
    render_right_prompt_on_last_line: false
    table: {
        mode: rounded
        index_mode: auto
        show_head: true
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
            truncating_suffix: "..."
        }
    }
}
