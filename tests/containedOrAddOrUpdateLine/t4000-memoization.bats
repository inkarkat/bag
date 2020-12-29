#!/usr/bin/env bats

load temp

@test "asks again on confirm each" {
    init
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=c
    run containedOrAddOrUpdateLine --memoize-group containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]

    cp -f "$INPUT" "$FILE"  # Restore original file.
    run containedOrAddOrUpdateLine --memoize-group containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]
}

@test "recalls positive choice on yes" {
    init
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateLine --memoize-group containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]

    cp -f "$INPUT" "$FILE"  # Restore original file.
    MEMOIZEDECISION_CHOICE=
    run containedOrAddOrUpdateLine --memoize-group containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ \'foo=new\'\.\ Will\ update\ it\ now\. ]]
}

@test "does not recall another file on yes" {
    init
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateLine --memoize-group containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]

    MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateLine --memoize-group containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE2"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE2")\ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]
}

@test "recalls another file on any" {
    init
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=a
    run containedOrAddOrUpdateLine --memoize-group containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]

    MEMOIZEDECISION_CHOICE=n
    run containedOrAddOrUpdateLine --memoize-group containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE2"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE2")\ does\ not\ yet\ contain\ \'foo=new\'\.\ Will\ update\ it\ now\. ]]
}
