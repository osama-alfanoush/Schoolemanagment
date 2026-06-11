const fs = require('fs');
const path = require('path');
const parser = require('@babel/parser');
const traverse = require('@babel/traverse').default;
const generate = require('@babel/generator').default;
const t = require('@babel/types');

const pagesDir = path.join(__dirname, 'src/pages');

function findTsxFiles(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach((file) => {
    file = path.join(dir, file);
    const stat = fs.statSync(file);
    if (stat && stat.isDirectory()) {
      results = results.concat(findTsxFiles(file));
    } else if (file.endsWith('.tsx')) {
      results.push(file);
    }
  });
  return results;
}

const files = findTsxFiles(pagesDir);
let changedCount = 0;

for (const file of files) {
  const code = fs.readFileSync(file, 'utf8');
  let changed = false;

  const ast = parser.parse(code, {
    sourceType: 'module',
    plugins: ['typescript', 'jsx'],
  });

  let needsBrandCardImport = false;
  let needsBrandButtonImport = false;

  traverse(ast, {
    ImportDeclaration(path) {
      if (!path.node) return;
      if (path.node.source.value === '@/components/ui/card') {
        const specifiers = path.node.specifiers;
        const cardIndex = specifiers.findIndex(s => s.imported && s.imported.name === 'Card');
        if (cardIndex !== -1) {
          specifiers.splice(cardIndex, 1);
          needsBrandCardImport = true;
          changed = true;
        }
        if (specifiers.length === 0) {
          path.remove();
          return; // Skip rest of checks since this node is gone
        }
      }
      
      if (!path.node) return;
      if (path.node.source.value === '@/components/ui/button') {
        const specifiers = path.node.specifiers;
        const btnIndex = specifiers.findIndex(s => s.imported && s.imported.name === 'Button');
        if (btnIndex !== -1) {
          specifiers.splice(btnIndex, 1);
          needsBrandButtonImport = true;
          changed = true;
        }
        if (specifiers.length === 0) {
          path.remove();
        }
      }
    },
    JSXIdentifier(path) {
      if (path.node.name === 'Card' && needsBrandCardImport) {
        path.node.name = 'BrandCard';
      }
      if (path.node.name === 'Button' && needsBrandButtonImport) {
        path.node.name = 'BrandButton';
      }
    }
  });

  if (changed) {
    let newCode = generate(ast, {}, code).code;
    
    // Add imports at the top
    let importStatements = '';
    if (needsBrandCardImport) importStatements += `import BrandCard from "@/components/ui/BrandCard";\n`;
    if (needsBrandButtonImport) importStatements += `import BrandButton from "@/components/ui/BrandButton";\n`;
    
    newCode = importStatements + newCode;

    fs.writeFileSync(file, newCode, 'utf8');
    changedCount++;
  }
}

console.log(`Updated ${changedCount} files with Brand components.`);
