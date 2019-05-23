
job('seed.seed') {
    description("seed job")
  //  label('seed')
//    disabled(true)
    logRotator {
        numToKeep 20
    }
    quietPeriod(5)
 
    steps {
        
        shell("""
            cp -r  \$JENKINS_HOME/src ./
            """.stripIndent())
        dsl{
            external('src/jobs/*Jobs.groovy')
        }
        systemGroovyCommand("""
        import org.jenkinsci.plugins.scriptsecurity.scripts.*
        ScriptApproval scriptApproval = ScriptApproval.get()
        scriptApproval.pendingScripts.each {
            scriptApproval.approveScript(it.hash)
        }
        println "Done"            
        """.stripIndent())
    }
    triggers {
        scm('* * * * *')
    }
}

